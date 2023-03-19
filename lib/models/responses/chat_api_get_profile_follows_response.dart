
import '../follow.dart';

class ChatApiGetProfileFollowsResponse {
  final List<Follow> list;

  ChatApiGetProfileFollowsResponse({
    required this.list,
  });

  factory ChatApiGetProfileFollowsResponse.fromJson(List<dynamic> parsedJson) {
    List<Follow> list = <Follow>[];

    print("get-comments-response ${parsedJson.length} comments");

    list = parsedJson.map((i) => Follow.fromJson(i)).toList();

    return ChatApiGetProfileFollowsResponse(list: list);
  }
}
