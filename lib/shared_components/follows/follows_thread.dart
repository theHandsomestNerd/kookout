import 'package:flutter/material.dart';

import '../../models/follow.dart';
import 'follow_solo.dart';

class FollowThread extends StatelessWidget {
  const FollowThread({
    super.key,
    required this.follows,
  });

  final List<Follow>? follows;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...follows != null
            ? (follows!).map((follow) {
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
