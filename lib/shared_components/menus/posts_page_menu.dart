import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../sanity/image_url_builder.dart';
import '../../wrappers/expanding_fab.dart';

class PostsPageMenu extends StatefulWidget {
  const PostsPageMenu({Key? key, required this.updateMenu, this.selected})
      : super(key: key);
  final updateMenu;
  final selected;

  @override
  State<PostsPageMenu> createState() => _PostsPageMenuState();
}

enum ProfileMenuOptions {
  MY_POSTS,
  POSTS,
  ADD_POST,
}

class _PostsPageMenuState extends State<PostsPageMenu> {
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
        ActionButton(
          tooltip: "Album",
          onPressed: () {
            Navigator.popAndPushNamed(context, '/settings');
          },
          icon: const Icon(Icons.photo_album),
        ),
        ActionButton(
          tooltip: "My Posts",
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
          tooltip: "Posts",
          onPressed: () {
            Navigator.pushNamed(context, '/postsPage');

          },
          icon: const Icon(Icons.timeline),
        ),
        ActionButton(
          tooltip: "Add Post",
          onPressed: () {
            Navigator.popAndPushNamed(context, '/createPostsPage');
          },
          icon: const Icon(Icons.post_add),
        ),
      ],
    );
  }
}
