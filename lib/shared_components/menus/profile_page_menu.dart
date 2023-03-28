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
enum ProfileMenuOptions {
  PROFILELIST,
  TIMELINE,
  LIKES_AND_FOLLOWS,
  BLOCKS,
  ALBUMS,
  POSTS
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
            widget.updateMenu(ProfileMenuOptions.POSTS.index);
          },
          icon: const Icon(Icons.post_add),
        ),

      ActionButton(
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.ALBUMS.index);
          },
          icon: const Icon(Icons.photo_album),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.LIKES_AND_FOLLOWS.index);
          },
          icon: const Icon(Icons.emoji_emotions),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.TIMELINE.index);
          },
          icon: const Icon(Icons.timeline),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.PROFILELIST.index);
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
