
import '../comment.dart';

class ChatApiGetProfileCommentsResponse {
  final List<Comment> list;

  ChatApiGetProfileCommentsResponse({
    required this.list,
  });

  factory ChatApiGetProfileCommentsResponse.fromJson(List<dynamic> parsedJson) {
    List<Comment> list = <Comment>[];

    print("get-comments-response ${parsedJson}");

    list = parsedJson.map((i) => Comment.fromJson(i)).toList();

    return ChatApiGetProfileCommentsResponse(list: list);
  }
}
