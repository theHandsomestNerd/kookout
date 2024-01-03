import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:go_router/go_router.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../wrappers/expanding_fab.dart';

class PostsPageMenu extends StatefulWidget {
  const PostsPageMenu({
    Key? key,
    required this.updateMenu,
    this.selected,
  }) : super(key: key);
  final Function updateMenu;

  final bool? selected;

  @override
  State<PostsPageMenu> createState() => _PostsPageMenuState();
}

enum ProfileMenuOptions { MY_POSTS, POSTS, ADD_POST, HOME }

class _PostsPageMenuState extends State<PostsPageMenu> {
  SanityImage?  profileImage;

  @override
  didChangeDependencies() async {
    profileImage =
        AuthInherited.of(context)?.authController?.myAppUser?.profileImage;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 158.0,
      children: [
        ActionButton(
          tooltip: "Settings",
          onPressed: () {
            GoRouter.of(context).go('/settings');

            // Navigator.popAndPushNamed(context, '/settings');
          },
          icon: const Icon(Icons.settings),
        ),
        // ActionButton(
        //   tooltip: "Album",
        //   onPressed: () {
        //     GoRouter.of(context).go('/settings');
        //
        //     // Navigator.popAndPushNamed(context, '/settings');
        //   },
        //   icon: const Icon(Icons.photo_album),
        // ),
        // ActionButton(
        //   tooltip: "My Posts",
        //   onPressed: () {
        //     GoRouter.of(context).go('/myProfile');
        //
        //     // Navigator.pushNamed(context, '/myProfile');
        //   },
        //   icon: profileImage != null
        //       ? CircleAvatar(
        //           backgroundImage: SanityImageBuilder.imageProviderFor(sanityImage: profileImage,showDefaultImage: true).image,
        //         )
        //       : const Icon(Icons.add),
        // ),
        ActionButton(
          tooltip: "Hashtags",
          onPressed: () {
            GoRouter.of(context).go('/hashtagCollections');
          },
          icon: const Icon(Icons.tag),
        ),
        ActionButton(
          tooltip: "Chapter Roster",
          onPressed: () {
            GoRouter.of(context).go('/chapterRoster');
          },
          icon: const Icon(Icons.list),
        ),
        ActionButton(
          tooltip: "Posts",
          onPressed: () {
            GoRouter.of(context).go('/postsPage');

            // Navigator.pushNamed(context, '/postsPage');
          },
          icon: const Icon(Icons.timeline),
        ),
        // ActionButton(
        //   tooltip: "Add Post",
        //   onPressed: () {
        //     GoRouter.of(context).go('/createPostsPage');
        //
        //     // Navigator.popAndPushNamed(context, '/createPostsPage');
        //   },
        //   icon: const Icon(Icons.post_add),
        // ),
        ActionButton(
          onPressed: () {
            GoRouter.of(context).go('/home');

            // Navigator.popAndPushNamed(context, '/home');
          },
          icon: const Icon(Icons.home),
        ),
      ],
    );
  }
}
