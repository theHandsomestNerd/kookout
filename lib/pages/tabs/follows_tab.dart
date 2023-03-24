import 'package:chat_line/layout/search_and_list.dart';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/follow.dart';
import '../../shared_components/follows/follows_thread.dart';

class FollowsTab extends StatefulWidget {
  const FollowsTab(
      {super.key,
      required this.chatController,
      required this.authController,
      required this.thisProfile,
      required this.isThisMe,
      required this.profileFollowedByMe,
      required this.profileFollows,
      required this.id});

  final AuthController authController;
  final ChatController chatController;
  final AppUser? thisProfile;
  final String id;
  final bool isThisMe;
  final List<Follow>? profileFollows;
  final Follow? profileFollowedByMe;

  @override
  State<FollowsTab> createState() => _FollowsTabState();
}

class _FollowsTabState extends State<FollowsTab> {
  @override
  Widget build(BuildContext context) {
    return SearchAndList(
      listChild: FollowThread(
        key: ObjectKey(widget.profileFollows),
        follows: widget.profileFollows ?? [],
      ),
    );
  }
}
