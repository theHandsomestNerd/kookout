import 'package:chat_line/models/comment.dart';
import 'package:chat_line/shared_components/search_box.dart';
import 'package:flutter/material.dart';

import '../../models/follow.dart';
import '../comments/comment_solo.dart';
import 'follow_solo.dart';

class FollowThread extends StatelessWidget {
  FollowThread({
    super.key,
    required this.follows,
  });

  final List<Follow> follows;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...follows != null
            ? (follows).map((follow) {
                return Column(
                  children: [
                    FollowSolo(follow: follow),
                    const Divider(),
                  ],
                );
              }).toList()
            : []
      ],
    );
  }
}
