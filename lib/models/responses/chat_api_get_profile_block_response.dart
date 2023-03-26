import 'package:flutter/foundation.dart';

import '../block.dart';

class ChatApiGetProfileBlocksResponse {
  final List<Block> list;

  ChatApiGetProfileBlocksResponse({
    required this.list,
  });

  factory ChatApiGetProfileBlocksResponse.fromJson(List<dynamic> parsedJson) {
    List<Block> tempList = <Block>[];

    if (kDebugMode) {
      print("get-block-response $parsedJson");
    }

    if(parsedJson.isNotEmpty) {
      tempList = parsedJson.map((i) => Block.fromJson(i)).toList();
    } else {
      tempList = [];
    }

    return ChatApiGetProfileBlocksResponse(list: tempList);
  }
}
