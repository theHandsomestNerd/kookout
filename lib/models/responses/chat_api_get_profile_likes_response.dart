import 'package:chat_line/models/like.dart';

class ChatApiGetProfileLikesResponse {
  final List<Like> list;

  ChatApiGetProfileLikesResponse({
    required this.list,
  });

  factory ChatApiGetProfileLikesResponse.fromJson(List<dynamic> parsedJson) {
    List<Like> list = <Like>[];

    print("get-likes-response ${parsedJson[0]}");

    list = parsedJson.map((i) => Like.fromJson(i)).toList();

    return ChatApiGetProfileLikesResponse(list: list);
  }
}
