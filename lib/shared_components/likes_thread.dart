import 'package:chat_line/models/comment.dart';
import 'package:chat_line/shared_components/search_box.dart';
import 'package:flutter/material.dart';

import '../models/follow.dart';
import '../models/like.dart';
import 'comment_solo.dart';
import 'follow_solo.dart';
import 'like_solo.dart';

class LikeThread extends StatelessWidget {
  LikeThread({
    super.key,
    required this.likes,
  });

  final List<Like> likes;

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
                ...(likes).map((like) {
                  return Column(
                    children: [LikeSolo(like: like), Divider()],
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
