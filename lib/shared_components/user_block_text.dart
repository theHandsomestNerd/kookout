import 'package:chat_line/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/Profile.dart';
import '../sanity/image_url_builder.dart';

class UserBlockText extends StatelessWidget {
  const UserBlockText({
    super.key,
    this.user,
  });

  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: Key((user?.userId ?? "") + (user?.displayName ?? "")),
      constraints: const BoxConstraints(),
      child: Row(
        children: [
          user?.profileImage!=null?Image.network(MyImageBuilder()
              .urlFor(user!.profileImage)
              ?.height(50)
              .width(50)
              .url() ??
              "",height: 30, width: 30,):Image.asset(height:30, width: 30, 'assets/blankProfileImage.png'),
          Flexible(
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile',
                    arguments: {"id": user?.userId});
              },
              child: Text(user?.displayName ?? ""),
            ),
          ),
        ],
      ),
    );
  }
}
