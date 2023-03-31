import 'package:chat_line/layout/full_page_layout.dart';
import 'package:chat_line/models/controllers/auth_inherited.dart';
import 'package:chat_line/models/controllers/post_controller.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/sanity/image_url_builder.dart';
import 'package:chat_line/shared_components/menus/app_menu.dart';
import 'package:chat_line/shared_components/menus/home_page_menu.dart';
import 'package:chat_line/shared_components/menus/login_menu.dart';
import 'package:chat_line/shared_components/menus/profile_page_menu.dart';
import 'package:chat_line/wrappers/card_with_actions.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/controllers/chat_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.postController});

  final PostController postController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser? highlightedProfile = null;
  Post? highlightedPost = null;
  late ChatController? chatController = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.postController.fetchHighlightedPost().then((value) {
      print("highlighted post ${value?.mainImage}");
      highlightedPost = value;
    });

    // highlightedProfile = chatController?.profileList[0];
  }

  bool isUserLoggedIn = false;

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    var theAuthController = AuthInherited.of(context)?.authController;
    var theChatController = AuthInherited.of(context)?.chatController;
    isUserLoggedIn = theAuthController?.myAppUser != null;
    // var profiles = await theChatController?.profileClient.fetchProfiles();
    chatController = theChatController;
    if (theAuthController?.myAppUser != null) {
      var theHighlightedProfile =
          await theChatController?.fetchHighlightedProfile();
      highlightedProfile = theHighlightedProfile;
    }
    setState(() {});
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
      floatingActionButton: !isUserLoggedIn
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
                image: highlightedProfile?.profileImage != null
                    ? NetworkImage(MyImageBuilder()
                        .urlFor(highlightedProfile?.profileImage!)!
                        .url())
                    : NetworkImage("https://placeimg.com/640/480/any"),
                action1Text:
                    "${highlightedProfile?.displayName?.toUpperCase()[0]}${highlightedProfile?.displayName?.substring(1).toLowerCase()}",
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
                caption: "${highlightedPost?.author?.displayName}: ${highlightedPost?.body}",
                image: highlightedPost?.mainImage != null
                    ? NetworkImage(MyImageBuilder()
                        .urlFor(highlightedPost?.mainImage!)!
                        .url())
                    : NetworkImage("https://placeimg.com/640/480/any"),
                action1Text: highlightedPost?.author?.displayName,
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
