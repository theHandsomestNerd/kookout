import 'package:flutter/material.dart';

import '../../models/block.dart';
import 'block_solo.dart';

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
      key: super.key,
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
