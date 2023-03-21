import 'package:chat_line/models/comment.dart';
import 'package:chat_line/shared_components/search_box.dart';
import 'package:flutter/material.dart';

import '../models/block.dart';
import '../models/follow.dart';
import '../models/like.dart';
import 'block_solo.dart';
import 'comment_solo.dart';
import 'follow_solo.dart';
import 'like_solo.dart';

class BlockThread extends StatelessWidget {
  BlockThread({
    super.key,
    required this.blocks,
  });

  final List<Block> blocks;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: key,
      constraints: BoxConstraints(),
      child: blocks.length > 0 ? ListView(
        children: [
          ...(blocks).map((block) {
            return Column(
              // children: [Text("block: block"), Divider()],
              children: [BlockSolo(block: block), Divider()],
            );
          }).toList()
        ],
      ):Text("You dont have any blocks"),
    );
  }
}
