import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

import '../app_user.dart';
import '../auth/auth_user.dart';
import 'auth_controller.dart';

class AuthInherited extends InheritedWidget {
  final AuthController? authController;
  final ChatController? chatController;
  final AuthUser? myLoggedInUser;
  final SanityImage? profileImage;

  AuthInherited(
      {super.key, this.profileImage,
      this.authController,
      this.chatController,
      this.myLoggedInUser,
      required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    var oldWidgetReformed = oldWidget as AuthInherited;

    if (oldWidgetReformed.myLoggedInUser?.email != myLoggedInUser?.email) {
      return true;
    }

    return true;
  }

  static AuthInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthInherited>();
  }
}
