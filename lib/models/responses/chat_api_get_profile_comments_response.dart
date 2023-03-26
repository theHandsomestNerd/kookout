
import 'package:flutter/foundation.dart';

import '../comment.dart';

class ChatApiGetProfileCommentsResponse {
  final List<Comment> list;

  ChatApiGetProfileCommentsResponse({
    required this.list,
  });

  factory ChatApiGetProfileCommentsResponse.fromJson(List<dynamic> parsedJson) {
    List<Comment> list = <Comment>[];

    if (kDebugMode) {
      print("get-comments-response $parsedJson");
    }

    list = parsedJson.map((i) => Comment.fromJson(i)).toList();

    return ChatApiGetProfileCommentsResponse(list: list);
  }
}
