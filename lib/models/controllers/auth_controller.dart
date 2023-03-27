import 'dart:convert';

import 'package:chat_line/config/api_options.dart';
import 'package:chat_line/models/auth/auth_user.dart';
import 'package:chat_line/wrappers/alerts_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../app_user.dart';

class AuthController {
  final AlertSnackbar _alertSnackbar = AlertSnackbar();

  String authBaseUrl = DefaultAppOptions.currentPlatform.authBaseUrl;

  late bool isLoggedIn = false;
  AuthUser? loggedInUser = null;
  AppUser? myAppUser = null;

  AuthController.init() {
    if(FirebaseAuth.instance.currentUser != null) {
      _getMyAppUser().then((user) {
        myAppUser = user;
      });

      _getLoggedInUser().then((user) {
        loggedInUser = user;
        if(user != null){
          isLoggedIn = true;
        } else {
          isLoggedIn = false;
        }
      });
    } else {
      isLoggedIn = false;
      myAppUser = null;
      loggedInUser = null;
    }

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        if (kDebugMode) {
          print('authController: User is currently signed out!');
        }
        isLoggedIn = false;
      } else {
        if (kDebugMode) {
          print('authController: User is signed in!');
        }
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
      print("Registering user $username");

      String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        final response = await http.post(
            Uri.parse("$authBaseUrl/register-app-user"),
            headers: {"Authorization": ("Bearer $token")});

        var processedResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("processedResponse ${processedResponse['profile']}");
        }

        AppUser myAppProfile = AppUser.fromJson(processedResponse['profile']);

        if (kDebugMode) {
          print("Auth api response $myAppProfile");
        }
        return myAppProfile;
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('authController: The password provided is too weak.');
        }
        _alertSnackbar.showErrorAlert("The Password is too weak.", context);
      } else if (e.code == 'email-already-in-use') {
        _alertSnackbar.showErrorAlert("Email Address already in use", context);

        // return showDialog<void>(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return const AlertMessagePopup(
        //           title: "Error",
        //           message: "Email Address already in use",
        //           isError: true);
        //     });
      } else if (e.code == 'invalid-email') {
        _alertSnackbar.showErrorAlert(
            "The email aadress is badly formatted.", context);
        // return showDialog<void>(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return const AlertMessagePopup(
        //           title: "Error",
        //           message: "The email aadress is badly formatted.",
        //           isError: true);
        //     });
      }
    }
  }

  Future<AuthUser?> updateUser(String username, String displayName,
      String filename, fileBytes, BuildContext context) async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$authBaseUrl/update-user-profile"));

      request.headers.addAll({"authorization": "Bearer $token"});

      if (filename != "") {
        request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
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
      if (kDebugMode) {
        print("Auth api response$response");
      }
      var myUser = await _getMyAppUser();
      var authUser = await _getLoggedInUser();
      myAppUser = myUser;
      loggedInUser = authUser;
      return authUser;
    } else {
      if (kDebugMode) {
        print("Cannot update user no token present...");
      }
    }
    return null;
  }

  Future<AppUser?> _getMyAppUser() async {
    if (kDebugMode) {
      print(
          "Retrieving My App Profile ${loggedInUser?.uid} ${FirebaseAuth.instance.currentUser?.email ?? ""}");
    }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (FirebaseAuth.instance.currentUser != null && token != null) {
      final response = await http.get(Uri.parse("$authBaseUrl/get-my-profile"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse = jsonDecode(response.body);

      if (processedResponse['myAppProfile'] != null) {
        AppUser responseModel =
            AppUser.fromJson(processedResponse['myAppProfile']);
        if (kDebugMode) {
          print("gey app user Auth api response ${responseModel}");
        }

        myAppUser = responseModel;

        return responseModel;
      }
    }
    return null;
  }

  Future<AuthUser?> _getLoggedInUser() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (FirebaseAuth.instance.currentUser == null && token != null) {
      if (kDebugMode) {
        print(
            "Retrieving My Auth Profile ${FirebaseAuth.instance.currentUser?.uid ?? ""}");
      }
      final response = await http.get(Uri.parse("$authBaseUrl/get-auth-user"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse = jsonDecode(response.body);

      AuthUser responseModel =
          AuthUser.fromJson(processedResponse['myAuthProfile']);
      if (kDebugMode) {
        print("get logged in user api response $responseModel");
      }

      loggedInUser = responseModel;

      return responseModel;
    }
    return null;
  }

  Future<AppUser?> getAppUser(String userId) async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (FirebaseAuth.instance.currentUser != null && userId != "" && token != null) {
      if (kDebugMode) {
        print("Retrieving App Profile $userId");
      }
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-profile/$userId"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse = jsonDecode(response.body);

      AppUser responseModel = AppUser.fromJson(processedResponse['appProfile']);
      if (kDebugMode) {
        print("get app user Auth api response $responseModel");
      }
      return responseModel;
    }
    return null;
  }
}
