import 'package:chat_line/layout/search_and_list.dart';
import 'package:chat_line/shared_components/blocks/blocks_thread.dart';
import 'package:flutter/material.dart';

import '../../models/block.dart';
import '../../models/controllers/auth_inherited.dart';

class BlocksTab extends StatefulWidget {
  const BlocksTab({super.key, required this.blocks, required this.unblockProfile});

  final List<Block> blocks;
  final unblockProfile;

  @override
  State<BlocksTab> createState() => _BlocksTabState();
}

class _BlocksTabState extends State<BlocksTab> {


  // @override
  // didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   var theChatController = AuthInherited.of(context)?.chatController;
  //   blocks = await theChatController?.updateMyBlocks();
  //   setState(() {});
  //   print("blocks dependencies changed $blocks");
  // }

  @override
  Widget build(BuildContext context) {
    return SearchAndList(
      isSearchEnabled: false,
      listChild: BlockThread(
        unblockProfile: widget.unblockProfile,
        blocks: widget.blocks ?? [],
      ),
    );
  }
}
