import 'package:kookout/layout/search_and_list.dart';
import 'package:kookout/models/controllers/analytics_controller.dart';
import 'package:kookout/shared_components/blocks/blocks_thread.dart';
import 'package:flutter/material.dart';

import '../../models/block.dart';
import '../../models/controllers/auth_inherited.dart';

class BlocksTab extends StatefulWidget {
  const BlocksTab({super.key, required this.blocks, required this.unblockProfile});

  final List<Block> blocks;
  final Function unblockProfile;

  @override
  State<BlocksTab> createState() => _BlocksTabState();
}

class _BlocksTabState extends State<BlocksTab> {

  late AnalyticsController analyticsController;

  @override
  didChangeDependencies() async {
    var theAnalyticsController = AuthInherited.of(context)?.analyticsController;
    await theAnalyticsController?.logScreenView("blocks-tab");
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAndList(
      isSearchEnabled: false,
      listChild: BlockThread(
        unblockProfile: widget.unblockProfile,
        blocks: widget.blocks,
      ),
    );
  }
}
