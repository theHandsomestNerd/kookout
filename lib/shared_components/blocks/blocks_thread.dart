import 'package:flutter/material.dart';

import '../../models/block.dart';
import 'block_solo.dart';

class BlockThread extends StatelessWidget {
  const BlockThread({
    super.key,
    required this.blocks,
    required this.unblockProfile
  });

  final List<Block> blocks;
  final unblockProfile;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: ObjectKey(blocks),
      constraints: const BoxConstraints(),
      child: blocks.isNotEmpty ? ListView(
        children: [
          ...(blocks).map((block) {
            return Flex(
              direction: Axis.vertical,
              // children: [Text("block: block"), Divider()],
              children: [BlockSolo(block: block, unblockProfile: unblockProfile), const Divider()],
            );
          }).toList()
        ],
      ):const Text("You dont have any blocks"),
    );
  }
}
