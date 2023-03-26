import 'dart:convert';

import 'package:chat_line/config/api_options.dart';
import 'package:chat_line/models/responses/chat_api_get_profile_posts_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../post.dart';

class PostController {
  String authBaseUrl = DefaultAppOptions.currentPlatform.authBaseUrl;

  List<Post> postsFuture = [];

  Future<List<Post>> retrievePosts() async {
    if (kDebugMode) {
      print("Retrieving Posts");
    }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(Uri.parse("$authBaseUrl/get-posts"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse = jsonDecode(response.body);

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

  refetchPosts() async {
    return retrievePosts();
  }

  PostController.init() {
    getPosts(FirebaseAuth.instance.currentUser?.uid ?? "").then((thePosts) {
      postsFuture = thePosts;
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        if (kDebugMode) {
          print('chatController: User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('chatController: User is signed in!');
        }
        postsFuture = await retrievePosts();
      }
    });
  }

  Future<List<Post>> getPosts(String userId) async {
    if (kDebugMode) {
      print("Retrieving Posts $userId");
    }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(Uri.parse("$authBaseUrl/get-all-posts"),
          headers: {"Authorization": ("Bearer $token")});

      var processedResponse = jsonDecode(response.body);

      if (processedResponse['posts'] != null) {
        ChatApiGetProfilePostsResponse responseModel =
            ChatApiGetProfilePostsResponse.fromJson(
                processedResponse['posts']);
        if (kDebugMode) {
          print("get posts api response ${responseModel.list}");
        }

        for (var element in responseModel.list) {
          if (kDebugMode) {
            print(element);
          }
        }

        return responseModel.list;
      } else {
        return [];
      }
    }
    return [];
  }

  Future<String> createPost(String? postToPost) async {
    var message = "Post request by ${FirebaseAuth.instance.currentUser?.uid}";

    if (kDebugMode) {
      print(message);
      print(postToPost);
    }

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.post(Uri.parse("$authBaseUrl/post"), body: {
        // "title": postToPost?.title,
        // "body": postToPost?.body,
        // "publishedAt": postToPost?.publishedAt,
        // "slug": postToPost?.slug,
        // "mainImage": postToPost?.mainImage,
      }, headers: {
        "Authorization": ("Bearer $token")
      });

      var processedResponse = jsonDecode(response.body);

      if (processedResponse['postStatus'] != null) {
        if (kDebugMode) {
          print(processedResponse['postStatus']);
        }
        String responseModel = processedResponse['postStatus'];
        if (kDebugMode) {
          print("$message status: $responseModel");
        }
        return responseModel;
      } else {
        return "FAIL";
      }
    }
    return "FAIL";
  }
}
