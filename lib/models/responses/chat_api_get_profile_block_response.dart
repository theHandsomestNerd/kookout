import '../block.dart';

class ChatApiGetProfileBlocksResponse {
  final List<Block> list;

  ChatApiGetProfileBlocksResponse({
    required this.list,
  });

  factory ChatApiGetProfileBlocksResponse.fromJson(List<dynamic> parsedJson) {
    List<Block> tempList = <Block>[];

    print("get-block-response ${parsedJson}");

    if(parsedJson.length > 0) {
      tempList = parsedJson.map((i) => Block.fromJson(i)).toList();
    } else {
      tempList = [];
    }

    return ChatApiGetProfileBlocksResponse(list: tempList);
  }
}
