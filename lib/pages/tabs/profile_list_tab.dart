import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import '../../shared_components/profile_list.dart';
import '../../shared_components/search_box.dart';

class ProfileListTab extends StatefulWidget {
  const ProfileListTab({
    super.key,
    required this.chatController,
    required this.authController,
  });

  final AuthController authController;
  final ChatController chatController;

  @override
  State<ProfileListTab> createState() => _ProfileListTabState();
}

class _ProfileListTabState extends State<ProfileListTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.chatController.updateProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        key: Key(widget.authController.toString()),
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Profiles',
          ),
          SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
                      child: SearchBox(
                        searchTerms: "",
                        setTerms: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ]
            ),
          ),
          Expanded(child: ProfileList(profiles: widget.chatController.profileList)),
        ],
      ),
    );
  }
}
