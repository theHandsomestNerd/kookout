import 'dart:convert';

import 'package:chat_line/config/api_options.dart';
import 'package:chat_line/models/extended_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_user.dart';
import '../comment.dart';
import '../follow.dart';
import '../like.dart';
import '../responses/auth_api_profile_list_response.dart';
import '../responses/chat_api_get_profile_comments_response.dart';
import '../responses/chat_api_get_profile_follows_response.dart';
import '../responses/chat_api_get_profile_likes_response.dart';

class ChatController {
  static final ChatController _singleton = ChatController._internal();

  factory ChatController() {
    return _singleton;
  }

  ChatController._internal();

  String authBaseUrl = DefaultAppOptions.currentPlatform.authBaseUrl;

  ExtendedProfile? extProfile;
  List<AppUser> profilesFuture=[];

  Future<List<AppUser>> retrieveProfiles() async {
    print("Retrieving Profiles");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-all-profiles"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        AuthApiProfileListResponse responseModelList =
            AuthApiProfileListResponse.fromJson(processedResponse['profiles']);
        print(
            "retrieve profiles Auth api response ${responseModelList.list.length}");
        profilesFuture = responseModelList.list;
        return responseModelList.list;
      }
    }
    return <AppUser>[];
  }

  refetchProfiles() async {
    return retrieveProfiles();
  }

  ChatController.init() {
    getExtendedProfile(FirebaseAuth.instance.currentUser?.uid ?? "")
        .then((theProfile) {
      extProfile = theProfile;
    });



    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('chatController: User is currently signed out!');
      } else {
        print('chatController: User is signed in!');
        extProfile = await getExtendedProfile(
            FirebaseAuth.instance.currentUser?.uid ?? "");
        profilesFuture = await retrieveProfiles();
      }
    });
  }

  refetchExtProfile() async {
    return getExtendedProfile(FirebaseAuth.instance.currentUser?.uid ?? "");
  }

  updateExtProfileChatUser(
      String userId, BuildContext context, ExtendedProfile newProfile) async {
    print("in updATE CREATE");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    print("token $token");
    // print("json profile ${jsonEncode(newProfile)}");
    if (token != null) {
      var body = {};

      if (newProfile.shortBio != null && newProfile.shortBio != "null") {
        body = {...body, "shortBio": newProfile.shortBio};
      }
      if (newProfile.longBio != null && newProfile.longBio != "null") {
        body = {...body, "longBio": newProfile.longBio};
      }
      if (newProfile.age != null && newProfile.age != "null") {
        body = {...body, "age": newProfile.age.toString()};
      }
      if (newProfile.weight != null && newProfile.weight != "null") {
        body = {...body, "weight": newProfile.weight.toString()};
      }
      if (newProfile.height != null) {
        body = {...body, "height": json.encode(newProfile.height)};
      }
      if (newProfile.facebook != null && newProfile.facebook != "null") {
        body = {...body, "facebook": newProfile.facebook};
      }
      if (newProfile.twitter != null && newProfile.twitter != "null") {
        body = {...body, "twitter": newProfile.twitter};
      }
      if (newProfile.instagram != null && newProfile.instagram != "null") {
        body = {...body, "instagram": newProfile.instagram};
      }
      if (newProfile.gender != null && newProfile.gender != "null") {
        body = {...body, "gender": newProfile.gender};
      }
      if (newProfile.partnerStatus != null &&
          newProfile.partnerStatus != "null") {
        body = {...body, "partnerStatus": newProfile.partnerStatus};
      }
      if (newProfile.ethnicity != null && newProfile.ethnicity != "null") {
        body = {...body, "ethnicity": newProfile.ethnicity};
      }
      if (newProfile.iAm != null && newProfile.iAm != "null") {
        body = {...body, "iAm": newProfile.iAm};
      }
      if (newProfile.imInto != null && newProfile.imInto != "null") {
        body = {...body, "imInto": newProfile.imInto};
      }
      if (newProfile.imOpenTo != null && newProfile.imOpenTo != "null") {
        body = {...body, "imOpenTo": newProfile.imOpenTo};
      }
      if (newProfile.whatIDo != null && newProfile.whatIDo != "null") {
        body = {...body, "whatIDo": newProfile.whatIDo};
      }
      if (newProfile.whatImLookingFor != null &&
          newProfile.whatImLookingFor != "null") {
        body = {...body, "whatImLookingFor": newProfile.whatImLookingFor};
      }
      if (newProfile.whatInterestsMe != null &&
          newProfile.whatInterestsMe != "null") {
        body = {...body, "whatInterestsMe": newProfile.whatInterestsMe};
      }
      if (newProfile.whereILive != null && newProfile.whereILive != "null") {
        body = {...body, "whereILive": newProfile.whereILive};
      }
      if (newProfile.sexPreferences != null &&
          newProfile.sexPreferences != "null") {
        body = {...body, "sexPreferences": newProfile.sexPreferences};
      }
      if (newProfile.hivStatus != null && newProfile.hivStatus != "null") {
        body = {...body, "hivStatus": newProfile.hivStatus};
      }

      print("body before sending request $body");

      final response = await http
          .post(Uri.parse("$authBaseUrl/update-create-ext-profile"), headers: {
        "Authorization": ("Bearer ${token ?? ""}")
      }, body: {
        ...body,
        // "nsfwFriendly": (newProfile.nsfwFriendly ?? false).toString(),
        // "isTraveling": (newProfile.isTraveling ?? false).toString(),
        // "lastTested": newProfile.lastTested.toString() ?? "",
        // "pronouns": newProfile.pronouns.toString() ?? "",
        // "hashtags": newProfile.hashtags.toString() ?? "",
      });

      print("response from update create $response");

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);
        print("processedResponse ${processedResponse['newExtProfile']}");

        ExtendedProfile myExtProfile =
            ExtendedProfile.fromJson(processedResponse['newExtProfile']);

        print("Auth api response ${myExtProfile}");
        extProfile = myExtProfile;
        await refetchProfiles();
        return myExtProfile;
      }
    }
  }

  Future<ExtendedProfile?> getExtendedProfile(String userId) async {
    print("Retrieving Ext Profile ${userId}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-ext-profile/$userId"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['extendedProfile'] != null) {
          ExtendedProfile responseModel =
              ExtendedProfile.fromJson(processedResponse['extendedProfile']);
          print("get app user Auth api response ${responseModel}");
          return responseModel;
        } else {
          return null;
        }
      }
    }
    return null;
  }

  Future<List<Like>> getProfileLikes(String userId) async {
    print("Retrieving Profile Likes ${userId}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-profile-likes/$userId"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['profileLikes'] != null) {
          ChatApiGetProfileLikesResponse responseModel =
              ChatApiGetProfileLikesResponse.fromJson(
                  processedResponse['profileLikes']);
          print("get profile likes api response ${responseModel.list}");

          responseModel.list.forEach((element) {
            print(element);
          });

          return responseModel.list;
        } else {
          return [];
        }
      }
    }
    return [];
  }
Future<List<Follow>> getProfileFollows(String userId) async {
    print("Retrieving Profile Follows ${userId}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-profile-follows/$userId"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['profileFollows'] != null) {
          ChatApiGetProfileFollowsResponse responseModel =
              ChatApiGetProfileFollowsResponse.fromJson(
                  processedResponse['profileFollows']);
          print("get profile follows api response ${responseModel.list}");

          responseModel.list.forEach((element) {
            print(element);
          });

          return responseModel.list;
        } else {
          return [];
        }
      }
    }
    return [];
  }

  Future<String> likeProfile(String userId) async {
    var message =
        "Like Profile $userId by ${FirebaseAuth.instance.currentUser?.uid}";
    print(message);

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.post(Uri.parse("$authBaseUrl/like-profile"),
          body: {"userId": userId},
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['likeStatus'] != null) {
          print(processedResponse['likeStatus']);
          String responseModel = processedResponse['likeStatus'];
          print("${message} status: ${responseModel}");
          return responseModel;
        } else {
          return "FAIL";
        }
      }
    }
    return "FAIL";
  }
Future<String> followProfile(String userId) async {
    var message =
        "Follow Profile $userId by ${FirebaseAuth.instance.currentUser?.uid}";
    print(message);

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.post(Uri.parse("$authBaseUrl/follow-profile"),
          body: {"userId": userId},
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['followStatus'] != null) {
          print(processedResponse['followStatus']);
          String responseModel = processedResponse['followStatus'];
          print("${message} status: ${responseModel}");
          return responseModel;
        } else {
          return "FAIL";
        }
      }
    }
    return "FAIL";
  }

  Future<String> unlikeProfile(String userId, Like currentLike) async {
    var message =
        "UnLike Profile $userId by ${FirebaseAuth.instance.currentUser?.uid}";
    print(message);



    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.post(Uri.parse("$authBaseUrl/unlike-profile"),
          body: {"likeId":currentLike.id},
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['unlikeStatus'] != null) {
          print(processedResponse['unlikeStatus']);
          String responseModel = processedResponse['unlikeStatus'];
          print("${message} status: ${responseModel}");
          return responseModel;
        } else {
          return "FAIL";
        }
      }
    }
    return "FAIL";
  }
Future<String> unfollowProfile(String userId, Follow currentFollow) async {
    var message =
        "UnFollow Profile $userId by ${FirebaseAuth.instance.currentUser?.uid}";
    print(message);



    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.post(Uri.parse("$authBaseUrl/unfollow-profile"),
          body: {"followId":currentFollow.id},
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['unfollowStatus'] != null) {
          print(processedResponse['unfollowStatus']);
          String responseModel = processedResponse['unfollowStatus'];
          print("${message} status: ${responseModel}");
          return responseModel;
        } else {
          return "FAIL";
        }
      }
    }
    return "FAIL";
  }

  Future<List<Comment>> getProfileComments(String userId) async {
    print("Retrieving Profile Comments ${userId}");
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.get(
          Uri.parse("$authBaseUrl/get-profile-comments/$userId"),
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['profileComments'] != null) {
          ChatApiGetProfileCommentsResponse responseModel =
          ChatApiGetProfileCommentsResponse.fromJson(
              processedResponse['profileComments']);
          print("get profile comments api response ${responseModel.list}");

          responseModel.list.forEach((element) {
            print(element);
          });

          return responseModel.list;
        } else {
          return [];
        }
      }
    }
    return [];
  }

  Future<String> commentProfile(String userId, String commentBody) async {
    var message =
        "Comment Profile $userId by ${FirebaseAuth.instance.currentUser?.uid}";
    print(message);
    print(commentBody);

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token != null) {
      final response = await http.post(Uri.parse("$authBaseUrl/comment-profile"),
          body: {"userId": userId, "commentBody": commentBody},
          headers: {"Authorization": ("Bearer ${token ?? ""}")});

      if (response.body != null) {
        var processedResponse = jsonDecode(response.body);

        if (processedResponse['commentStatus'] != null) {
          print(processedResponse['commentStatus']);
          String responseModel = processedResponse['commentStatus'];
          print("${message} status: ${responseModel}");
          return responseModel;
        } else {
          return "FAIL";
        }
      }
    }
    return "FAIL";
  }
}
