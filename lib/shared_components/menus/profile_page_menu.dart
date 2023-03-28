import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../sanity/image_url_builder.dart';
import '../../wrappers/expanding_menu.dart';

class ProfilePageMenu extends StatefulWidget {
  const ProfilePageMenu({Key? key, required this.updateMenu}) : super(key: key);
final updateMenu;
  @override
  State<ProfilePageMenu> createState() => _ProfilePageMenuState();
}

class _ProfilePageMenuState extends State<ProfilePageMenu> {
  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 158.0,
      children: [
        ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/settings');
          },
          icon: const Icon(Icons.settings),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(5);
          },
          icon: const Icon(Icons.post_add),
        ),

      ActionButton(
          onPressed: () {
            widget.updateMenu(4);
          },
          icon: const Icon(Icons.photo_album),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(2);
          },
          icon: const Icon(Icons.emoji_emotions),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(1);
          },
          icon: const Icon(Icons.timeline),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(0);
          },
          icon: const Icon(Icons.people),
        ),
        ActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/myProfile');
          },
          icon: CircleAvatar(
            backgroundImage: NetworkImage(
              MyImageBuilder()
                  .urlFor(AuthInherited.of(context)
                  ?.authController
                  ?.myAppUser
                  ?.profileImage)
                  ?.height(100)
                  .width(100)
                  .url() ??
                  "",
            ),
          ),
        ),
      ],
    );
  }
}
