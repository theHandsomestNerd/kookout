import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import '../models/Profile.dart';
import '../shared_components/profile_list.dart';

class LoggedInHomePage extends StatefulWidget {
  const LoggedInHomePage(
      {super.key,
      required this.authController,
      required this.chatController,
      required this.drawer});

  final AuthController? authController;
  final ChatController? chatController;
  final Widget drawer;

  @override
  State<LoggedInHomePage> createState() => _LoggedInHomePageState();
}

class _LoggedInHomePageState extends State<LoggedInHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    @override
    void initState() {
      super.initState();
      widget.chatController?.refetchProfiles();
    }

    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        // Here we take the value from the LoggedInHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Chat Line - Login"),
      ),
      body: Center(
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
            ProfileList(profiles: widget.chatController?.profilesFuture ?? []),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
