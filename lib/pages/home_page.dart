import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.authController, required this.drawer});

  final AuthController authController;
  final drawer;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool _isUserLoggedIn = false;
  // late User? _loggedInUser;

  @override
  _HomePageState() {
    // _isUserLoggedIn = widget.authController.isLoggedIn ?? false;
    // if(widget.authController.loggedInUser != null) {
    //   _loggedInUser = widget.authController.loggedInUser;
    // }
  }

  _getMenu() {
    List<Widget> widgets = [];

    if (widget.authController.isLoggedIn == true) {
      widgets.add(
        MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          // style: ButtonStyle(
          //     backgroundColor: _isMenuItemsOnly
          //         ? MaterialStateProperty.all(Colors.red)
          //         : MaterialStateProperty.all(Colors.white)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/loggedInHome');
          },
          child: Text("Go to Logged in"),
        ),
      );
    } else {
      widgets.addAll(
        [MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          // style: ButtonStyle(
          //     backgroundColor: _isMenuItemsOnly
          //         ? MaterialStateProperty.all(Colors.red)
          //         : MaterialStateProperty.all(Colors.white)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/login');
          },
          child: Text("Login"),
        ),
        MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          // style: ButtonStyle(
          //     backgroundColor: _isMenuItemsOnly
          //         ? MaterialStateProperty.all(Colors.red)
          //         : MaterialStateProperty.all(Colors.white)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/register');
          },
          child: Text("New Account"),
        ),]
      );
    }

    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      ),
    );
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
      drawer: widget.drawer,
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Chat Line - Home"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          key: Key(widget.authController.isLoggedIn.toString()),
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
              'Home Page',
            ),
            SizedBox(
              width: 350,
              child: Column(
                children: [
                  Text(widget.authController.isLoggedIn
                      ? "You are logged in as ${widget.authController.loggedInUser?.email}"
                      : "you are logged out"),
                ],
              ),
            ),
            _getMenu()
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
