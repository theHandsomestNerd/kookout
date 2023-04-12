
import '../follow.dart';

class ChatApiGetProfileFollowsResponse {
  final List<Follow> list;
  final Follow? amIInThisList;

  ChatApiGetProfileFollowsResponse({
    required this.list,
    this.amIInThisList,
  });

  factory ChatApiGetProfileFollowsResponse.fromJson(Map<String, dynamic> json) {
    getListOfFollows(List<dynamic> parsedJson) {
      return parsedJson.map((i) => Follow.fromJson(i)).toList();
    }

    List<Follow> list = <Follow>[];
    Follow? amIInThisList;

    list = getListOfFollows(json['profileFollows']);
    if (json['amIInThisList'] != null && json['amIInThisList'] != "null") {
      amIInThisList = Follow.fromJson(json['amIInThisList']);
    }

    return ChatApiGetProfileFollowsResponse(list: list, amIInThisList: amIInThisList);
  }
}
