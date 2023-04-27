import 'package:cookowt/shared_components/menus/home_page_menu.dart';
import 'package:cookowt/shared_components/menus/posts_page_menu.dart';
import 'package:cookowt/shared_components/menus/profile_page_menu.dart';
import 'package:cookowt/wrappers/app_scaffold_wrapper.dart';
import 'package:flutter/material.dart';

import '../shared_components/posts/post_thread.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return AppScaffoldWrapper(
      floatingActionMenu: HomePageMenu(updateMenu: (){},),

      child: Flex(
        direction: Axis.vertical,
        children: const [
          Expanded(
            child: PostThread(),
          ),
        ],
      ),
    );
  }
}
