import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/controllers/auth_inherited.dart';
import '../../shared_components/profile/profile_grid.dart';
import '../../shared_components/search_box.dart';

class ProfileListTab extends StatefulWidget {
  const ProfileListTab({
    super.key,
  });


  @override
  State<ProfileListTab> createState() => _ProfileListTabState();
}

class _ProfileListTabState extends State<ProfileListTab> {

  late List<AppUser> profileList=[];
  late ChatController? chatController = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    var theChatController = AuthInherited.of(context)?.chatController;
    chatController = theChatController;
    profileList = await chatController?.updateProfiles();
    setState(() {});
    print("dependencies changed profile list ${profileList}");
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: widget.key,
      constraints: const BoxConstraints(),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
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
          Expanded(key: widget.key,child: ProfileGrid(profiles: profileList)),
        ],
      ),
    );
  }
}
