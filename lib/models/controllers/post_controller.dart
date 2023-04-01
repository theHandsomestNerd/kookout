import 'dart:convert';
import 'dart:math';

import 'package:chat_line/config/api_options.dart';
import 'package:chat_line/models/responses/chat_api_get_profile_posts_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../post.dart';

class PostController {
  String authBaseUrl = DefaultAppOptions.currentPlatform.authBaseUrl;

  List<Post> postsFuture = [];

  Future<List<Post>> retrievePosts() async {
    if (kDebugMode) {
      print("Retrieving Posts");
    }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null && token != "") {
      var response;
      response = await http.get(Uri.parse("$authBaseUrl/get-all-posts"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse;
      try {
        processedResponse = jsonDecode(response.body);
      } catch (err) {
        if (kDebugMode) {
          print("err $token ${response.body}");
        }
        return [];
      }

      ChatApiGetProfilePostsResponse responseModelList =
          ChatApiGetProfilePostsResponse.fromJson(processedResponse['posts']);
      if (kDebugMode) {
        print(
            "retrieve posts Auth api response ${responseModelList.list.length}");
      }
      postsFuture = responseModelList.list;
      return responseModelList.list;
    }
    return <Post>[];
  }

  Future<Post?> fetchHighlightedPost() async {
    var thePosts = await retrievePosts();
    postsFuture = thePosts;


    if (thePosts != null && thePosts.length > 0) {
      thePosts.removeWhere((element) {
        if (element.mainImage == null) {
          return true;
        }
        return false;
      });

      var rng = Random();
      rng.nextInt(thePosts.length);
        if (kDebugMode) {
          print("THe posts are not empty ${thePosts.length}");
        }
      if (thePosts.isNotEmpty) {
        return thePosts[rng.nextInt(thePosts.length - 1)];
      }
    }

    return null;
  }

  refetchPosts() async {
    return retrievePosts();
  }

  PostController.init() {
    getPosts().then((thePosts) {
      postsFuture = thePosts;
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        if (kDebugMode) {
          print('postController: User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('postController: User is signed in!');
        }
        postsFuture = await retrievePosts();
      }
    });
  }

  Future<List<Post>> getPosts() async {
    // if (kDebugMode) {
    //   print("Retrieving Posts $userId");
    // }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(Uri.parse("$authBaseUrl/get-all-posts"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse = jsonDecode(response.body);

      // if (kDebugMode) {
      //   print(processedResponse);
      // }
      if (processedResponse['posts'] != null) {
        ChatApiGetProfilePostsResponse responseModel =
            ChatApiGetProfilePostsResponse.fromJson(processedResponse['posts']);
        // if (kDebugMode) {
        //   print("get posts api response ${responseModel.list}");
        // }

        // for (var element in responseModel.list) {
        //   if (kDebugMode) {
        //     print(element);
        //   }
        // }

        return responseModel.list;
      } else {
        return [];
      }
    }
    return [];
  }

  Future<String> createPost(
      String postBody, String filename, fileBytes, BuildContext context) async {
    var message = "Post request by ${FirebaseAuth.instance.currentUser?.uid}";
    if (kDebugMode) {
      print(message);
    }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      var request =
          http.MultipartRequest('POST', Uri.parse("$authBaseUrl/create-post"));

      request.headers.addAll({"authorization": "Bearer $token"});

      if (filename != "") {
        request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
            contentType: MediaType('application', 'octet-stream'),
            filename: filename));
      }

      // if (loggedInUser?.email != username) {
      request.fields['postBody'] = postBody;
      // }

      final response = await request.send();
      // if (kDebugMode) {
      //   print("post controller api response$response");
      // }

      return "SUCCCESS";
    } else {
      if (kDebugMode) {
        print("Cannot update user no token present...");
      }
    }
    return "FAIL";
  }
}
