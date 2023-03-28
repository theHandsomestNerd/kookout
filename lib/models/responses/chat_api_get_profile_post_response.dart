
import 'package:flutter/foundation.dart';

import '../post.dart';

class ChatApiGetProfilePostResponse {
  final Post? post;

  ChatApiGetProfilePostResponse({
    required this.post,
  });

  factory ChatApiGetProfilePostResponse.fromJson(Map<String,dynamic> parsedJson) {
    Post? thePost = null;

    if (kDebugMode) {
      print("get-posts-response ${parsedJson}");
    }

    if(parsedJson['createdPost'] != null) {
      thePost = Post.fromJson(parsedJson['createdPost']);
    }

    return ChatApiGetProfilePostResponse(post: thePost);
  }
}
