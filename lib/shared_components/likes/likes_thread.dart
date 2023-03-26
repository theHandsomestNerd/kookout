import 'package:flutter/material.dart';

import '../../models/like.dart';
import 'like_solo.dart';

class LikeThread extends StatelessWidget {
  const LikeThread({
    super.key,
    required this.likes,
  });

  final List<Like>? likes;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...likes != null ? (likes??[]).map(
          (like) {
            return Column(
              children: [
                LikeSolo(like: like),
                const Divider(),
              ],
            );
          },
        ).toList():[]
      ],
    );
  }
}
