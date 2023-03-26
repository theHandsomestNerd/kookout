import 'package:chat_line/models/like.dart';
import 'package:flutter/foundation.dart';

class ChatApiGetProfileLikesResponse {
  final List<Like> list;

  ChatApiGetProfileLikesResponse({
    required this.list,
  });

  factory ChatApiGetProfileLikesResponse.fromJson(List<dynamic> parsedJson) {
    List<Like> list = <Like>[];

    if (kDebugMode) {
      print("get-likes-response $parsedJson");
    }

    list = parsedJson.map((i) => Like.fromJson(i)).toList();

    return ChatApiGetProfileLikesResponse(list: list);
  }
}
