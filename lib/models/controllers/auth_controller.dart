import 'dart:convert';

import 'package:chat_line/config/api_options.dart';
import 'package:chat_line/models/responses/auth_api_profile_list_response.dart';
import 'package:chat_line/models/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

import '../../shared_components/alert_message_popup.dart';
import '../app_user.dart';

class AuthController {
  static final AuthController _singleton = AuthController._internal();

  factory AuthController() {
    return _singleton;
  }

  AuthController._internal();

  String authBaseUrl = DefaultAppOptions.currentPlatform.authBaseUrl;

  late bool isLoggedIn = false;
  AuthUser? loggedInUser;
  AppUser? myAppUser = null;

  AuthController.init() {
    _getLoggedInUser().then((user){
      loggedInUser = user;
    });

    _getMyAppUser().then((user){
      myAppUser = user;
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('authController: User is currently signed out!');
        isLoggedIn = false;
      } else {
        print('authController: User is signed in!');
        isLoggedIn = true;
      }
      loggedInUser = await _getLoggedInUser();
      // get sanity user
      myAppUser = await _getMyAppUser();
    });
  }

  registerUser(String username, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        final response = await http.post(
            Uri.parse("$authBaseUrl/register-app-user"),
            headers: {"Authorization": ("Bearer ${token ?? ""}")});

        if (response.body != null) {
          var processedResponse = jsonDecode(response.body);
          print("processedResponse ${processedResponse['profile']}");

          AppUser myAppProfile = AppUser.fromJson(processedResponse['profile']);

          print("Auth api response ${myAppProfile}");
          return myAppProfile;
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('authController: The password provided is too weak.');
        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return const AlertMessagePopup(
                  title: "Error",
                  message: "The Password is too weak.",
                  isError: true);
            });
      } else if (e.code == 'email-already-in-use') {
        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return const AlertMessagePopup(
                  title: "Error",
                  message: "Email Address already in use",
                  isError: true);
            });
      } else if (e.code == 'invalid-email') {
        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return const AlertMessagePopup(
                  title: "Error",
                  message: "The email aadress is badly formatted.",
                  isError: true);
            });
      }
    }
  }

  Future<AuthUser?> updateUser(String username, String displayName, String filename, fileBytes,
      BuildContext context) async {

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$authBaseUrl/update-user-profile"));

      request.headers.addAll({
        "authorization": "Bearer $token"
      });

      Configuration config = const Configuration(
        outputType: ImageOutputType.jpg,
        // can only be true for Android and iOS while using ImageOutputType.jpg or ImageOutputType.pngÏ
        useJpgPngNativeCompressor: false,
        // set quality between 0-100
        quality: 90,
      );

      final param = ImageFileConfiguration(
          input: ImageFile(
              filePath: filename,
              rawBytes: fileBytes),
          config: config);
      final compressed = await compressor.compressWebpThenJpg(param);

      if(filename != "") {
        request.files.add(http.MultipartFile.fromBytes(
            'file',
            compressed.rawBytes,
            contentType: MediaType('application', 'octet-stream'),
            filename: filename));
      }

      if (loggedInUser?.email != username) {
        request.fields['email'] = username;
      }

      if (loggedInUser?.displayName != displayName) {
        request.fields['displayName'] = displayName;
      }

      final response = await request.send();
      print("Auth api response${response}");
      var myUser = await _getMyAppUser();
      print("my new user $myUser");
      var authUser = await _getLoggedInUser();
      print("my new user $authUser");
      myAppUser = myUser;
      loggedInUser = authUser;
      return authUser;
    } else {
      print("Cannot update user no token present...");
    }
     return null;
  }


  Future<AppUser?> _getMyAppUser() async {
    print("Retrieving My App Profile ${loggedInUser?.uid} ${FirebaseAuth.instance.currentUser?.email ?? ""}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-my-profile"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if(processedResponse['myAppProfile'] != null) {
          AppUser responseModel =
              AppUser.fromJson(processedResponse['myAppProfile']);
          print("gey app user Auth api response ${responseModel.profileImage}");
          return responseModel;
        }
      }
    }
    return null;
  }

  Future<AuthUser?> _getLoggedInUser() async {
    print("Retrieving My Auth Profile ${loggedInUser?.uid} ${FirebaseAuth.instance.currentUser?.email ?? ""}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-auth-user"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        AuthUser responseModel = AuthUser.fromJson(processedResponse['myAuthProfile']);
        print("get logged in user api response ${responseModel}");


        return responseModel;
      }
    }
    return null;
  }

  Future<AppUser?> getAppUser(String userId) async {
    print("Retrieving App Profile ${userId}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-profile/$userId"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        AppUser responseModel =
        AppUser.fromJson(processedResponse['appProfile']);
        print("get app user Auth api response ${responseModel}");
        return responseModel;
      }
    }
    return null;
  }
}
