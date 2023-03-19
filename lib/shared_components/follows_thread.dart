import 'package:chat_line/models/comment.dart';
import 'package:chat_line/shared_components/search_box.dart';
import 'package:flutter/material.dart';

import '../models/follow.dart';
import 'comment_solo.dart';
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
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(
          height: 100,
          child: Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0,0,0,0),
                  child: SearchBox(
                    searchTerms: "",
                    setTerms: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: ListView(
              children: [
                ...(follows).map((follow) {
                  return Column(
                    children: [FollowSolo(follow: follow), Divider()],
                  );
                }).toList()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
