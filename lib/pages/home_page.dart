import 'package:chat_line/layout/full_page_layout.dart';
import 'package:chat_line/models/controllers/auth_inherited.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/shared_components/menus/app_menu.dart';
import 'package:chat_line/shared_components/menus/home_page_menu.dart';
import 'package:chat_line/shared_components/menus/login_menu.dart';
import 'package:chat_line/shared_components/menus/profile_page_menu.dart';
import 'package:chat_line/wrappers/card_with_actions.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/controllers/chat_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppUser? highlightedProfile = null;
  late Post? highlightedPost = null;


  bool isUserLoggedIn = false;
  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    isUserLoggedIn = AuthInherited.of(context)?.authController?.myAppUser != null;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      floatingActionButton:
          !isUserLoggedIn
              ? LoginMenu()
              : HomePageMenu(
                  updateMenu: () => {},
                ),
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Chat Line - Home"),
      ),
      body: FullPageLayout(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: CardWithActions(
                action1Text: "This Profile Name",
                action2Text: 'All Profiles',
                action1OnPressed: () {
                  if (highlightedProfile?.userId != null) {
                    Navigator.pushNamed(context, '/profile',
                        arguments: {"id": highlightedProfile?.userId});
                  }
                },
                action2OnPressed: () {
                  Navigator.pushNamed(context, '/profilesPage');
                },
              ),
            ),
            Expanded(
              child: CardWithActions(
                action1Text: "This Post",
                action2Text: 'All Posts',
                action1OnPressed: () {
                  if (highlightedPost?.id != null) {
                    Navigator.pushNamed(context, '/post',
                        arguments: {"id": highlightedPost?.id});
                  }
                },
                action2OnPressed: () {
                  Navigator.pushNamed(context, '/postsPage');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
