import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../sanity/image_url_builder.dart';
import '../../wrappers/expanding_fab.dart';

class ProfilePageMenu extends StatefulWidget {
  const ProfilePageMenu({Key? key, required this.updateMenu, this.selected}) : super(key: key);
final updateMenu;
final selected;
  @override
  State<ProfilePageMenu> createState() => _ProfilePageMenuState();
}
enum ProfileMenuOptions {
  PROFILELIST,
  TIMELINE,
  INBOX,
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
          tooltip: "Settings",
          onPressed: () {
            Navigator.popAndPushNamed(context, '/settings');
          },
          icon: const Icon(Icons.settings),
        ),
        // ActionButton(
        //   tooltip: "Posts",
        //   onPressed: () {
        //     widget.updateMenu(ProfileMenuOptions.POSTS.index);
        //   },
        //   icon: const Icon(Icons.post_add),
        // ),

      ActionButton(
        tooltip: "Album",
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.ALBUMS.index);
          },
          icon: const Icon(Icons.photo_album),
        ),
        ActionButton(
          tooltip: "Inbox",
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.INBOX.index);
          },
          icon: const Icon(Icons.inbox),
        ),
        ActionButton(
          tooltip: "Timeline",
          onPressed: () {
            widget.updateMenu(ProfileMenuOptions.TIMELINE.index);
          },
          icon: const Icon(Icons.timeline),
        ),

        ActionButton(
          tooltip: "My Profile",
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
        ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.home),
        ),
      ],
    );
  }
}
