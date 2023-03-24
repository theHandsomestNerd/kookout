import 'package:chat_line/layout/search_and_list.dart';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/shared_components/blocks/blocks_thread.dart';
import 'package:flutter/material.dart';

import '../../models/block.dart';

class BlocksTab extends StatefulWidget {
  const BlocksTab(
      {super.key,
      required this.authController,
      required this.chatController,
      required this.blocks});

  final AuthController authController;
  final ChatController chatController;
  final List<Block> blocks;

  @override
  State<BlocksTab> createState() => _BlocksTabState();
}

class _BlocksTabState extends State<BlocksTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.chatController.updateMyBlocks();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAndList(isSearchEnabled:false, listChild: BlockThread(
      blocks: widget.blocks,
    ),);
  }
}
