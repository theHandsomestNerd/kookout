import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/pages/tabs/blocks_tab.dart';
import 'package:chat_line/pages/tabs/posts_tab.dart';
import 'package:chat_line/pages/tabs/profile_list_tab.dart';
import 'package:chat_line/pages/tabs/timeline_events_tab.dart';
import 'package:flutter/material.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage(
      {super.key,
      required this.authController,
      required this.chatController,
      required this.drawer});

  final AuthController authController;
  final ChatController chatController;
  final Widget drawer;

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // widget.chatController.updateProfiles();
    // widget.chatController.updateTimelineEvents();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget _widgetOptions(_selectedIndex) {
    var theOptions = <Widget>[
      ProfileListTab(
        key: ObjectKey(widget.chatController.profileList),
        authController: widget.authController,
        chatController: widget.chatController,
      ),
      TimelineEventsTab(chatController: widget.chatController, authController: widget.authController, timelineEvents: widget.chatController.timelineOfEvents, id: widget.authController.myAppUser?.userId??""),
      const Text(
        'Index 3: Likes and Follows',
        style: optionStyle,
      ),
      BlocksTab(
        key: ObjectKey(widget.chatController.myBlockedProfiles),
        blocks: widget.chatController.myBlockedProfiles ?? [],
        authController: widget.authController,
        chatController: widget.chatController,
      ),
      const Text(
        'Index 4: Albums',
        style: optionStyle,
      ),
      PostsTab(
        id: widget.authController?.myAppUser?.userId ?? "",
      ),
    ];

    return theOptions.elementAt(_selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        key: ObjectKey(widget.chatController),
        drawer: widget.drawer,
        appBar: AppBar(
          // Here we take the value from the LoggedInHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Chat Line - Profiles"),
        ),
        body: ConstrainedBox(
            key: Key(_selectedIndex.toString()),
            constraints: BoxConstraints(),
            child: _widgetOptions(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Profiles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              label: 'Timeline',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions),
              label: 'Relationships',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.block),
              label: 'Blocked Profiles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: 'Albums',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Posts',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[800],
          unselectedItemColor: Colors.black,
          onTap:
              _onItemTapped, // This trailing comma makes auto-formatting nicer for build methods.
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
