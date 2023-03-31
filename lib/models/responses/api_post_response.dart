

import '../post.dart';

class ApiPostResponse {
  final Post? post;

  ApiPostResponse({
    required this.post,
  });

  factory ApiPostResponse.fromJson(Map<String,dynamic> parsedJson) {
    Post? thePost = null;

    // if (kDebugMode) {
    //   print("get-posts-response $parsedJson");
    // }

    if(parsedJson['createdPost'] != null) {
      thePost = Post.fromJson(parsedJson['createdPost']);
    }

    return ApiPostResponse(post: thePost);
  }
}
