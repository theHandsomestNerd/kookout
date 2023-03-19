import 'package:chat_line/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/Profile.dart';
import '../sanity/image_url_builder.dart';

class UserBlockMini extends StatelessWidget {
  const UserBlockMini({
    super.key,
    this.user,
  });

  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: Key((user?.userId ?? "") +
          (user?.displayName ?? "") +
          (user?.profileImage?.toString() ?? "")),
      constraints: const BoxConstraints(),
      child: Flexible(
        child: Row(
          children: [
            MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/myProfile');
              },
              child: Row(
                children: [
                  user?.profileImage != null
                      ? Image.network(
                          MyImageBuilder()
                                  .urlFor(user?.profileImage ?? "")
                                  ?.height(50)
                                  .width(50)
                                  .url() ??
                              "",
                          height: 80,
                          width: 80,
                        )
                      : SizedBox(
                          height: 80,
                          width: 80,
                        ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user?.displayName ?? ""),
                          Text(user?.email ?? "")
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/editProfile');
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 24.0,
                    semanticLabel: 'Edit Profile',
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
