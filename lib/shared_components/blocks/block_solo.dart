import 'package:chat_line/shared_components/user_block_text.dart';
import 'package:flutter/material.dart';

import '../../models/block.dart';

class BlockSolo extends StatelessWidget {
  const BlockSolo({
    super.key,
    required this.block,
  });

  final Block block;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Flexible(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    Icons.block,
                    size: 24.0,
                    semanticLabel: 'Likes',
                  ),
                ),
              ),
              Expanded(flex: 12, child: UserBlockText(user: block.blocked)),
            ],
          ),
        ),
      ),
    );
  }
}
