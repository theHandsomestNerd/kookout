import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/shared_components/likes_thread.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/like.dart';

class LikesTab extends StatefulWidget {
  const LikesTab(
      {super.key,
      required this.chatController,
      required this.authController,
      required this.thisProfile,
      required this.isThisMe,
      required this.profileLikedByMe,
      required this.profileLikes,
      required this.id});

  final AuthController authController;
  final ChatController chatController;
  final AppUser? thisProfile;
  final String id;
  final bool isThisMe;
  final List<Like>? profileLikes;
  final Like? profileLikedByMe;

  @override
  State<LikesTab> createState() => _LikesTabState();
}

class _LikesTabState extends State<LikesTab> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: LikeThread(
              key: ObjectKey(widget.profileLikes),
              likes: widget.profileLikes ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
