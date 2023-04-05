import 'package:cookout/wrappers/card_wrapped.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/controllers/analytics_controller.dart';
import '../models/controllers/auth_inherited.dart';
import '../shared_components/logo.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({
    super.key,
  });

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {

  didChangeDependencies() async {
    super.didChangeDependencies();

    AnalyticsController? theAnalyticsController =
        AuthInherited.of(context)?.analyticsController;

    theAnalyticsController?.logScreenView('Logout');
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
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Logo(),
      ),
      body: Center(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Logout',
            ),
            CardWrapped(
              child: SizedBox(
                width: 350,
                child: Column(
                  children: [
                    const Text("logoutBelow"),
                    MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      // style: ButtonStyle(
                      //     backgroundColor: _isMenuItemsOnly
                      //         ? MaterialStateProperty.all(Colors.red)
                      //         : MaterialStateProperty.all(Colors.white)),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut().then((x) {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        });
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
