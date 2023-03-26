import 'package:chat_line/models/app_user.dart';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/wrappers/alerts_snackbar.dart';
import 'package:chat_line/wrappers/card_wrapped.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/controllers/auth_inherited.dart';
import '../shared_components/app_drawer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    // required this.authController,
    required,
    this.drawer,
  });

  // final AuthController authController;
  final AppDrawer? drawer;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _loginUsername = "";
  String _loginPassword = "";

  @override
  void initState() {
    super.initState();

    _loginPassword = '';
    _loginUsername = '';
  }

  void _setUsername(String newUsername) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _loginUsername = newUsername;
    });
  }

  void _setPassword(String newPassword) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _loginPassword = newPassword;
    });
  }

  Future<void> _registerUser(context) async {
    try {
      print("authcontroller ${AuthInherited.of(context)?.authController}");
      AppUser myAppUser = await AuthInherited.of(context)?.authController?.registerUser(_loginUsername, _loginPassword, context);
      if (kDebugMode) {
        print(myAppUser);
      }
      Navigator.popAndPushNamed(context, '/editProfile');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    AlertSnackbar().showSuccessAlert('Account Created...Take a second to Fill in your profile.', context);

    return;
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
        // Here we take the value from the RegisterPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Chat Line - Register"),
      ),
      body: CardWrapped(
        height: 450,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
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
                'Register',
              ),
              SizedBox(
                width: 450,
                child: Column(
                  children: [
                    TextFormField(
                      key: ObjectKey("$_loginUsername$_loginPassword-user"),
                      autofocus:
                          _loginPassword.isEmpty && _loginUsername.isNotEmpty,
                      initialValue: _loginUsername,
                      onChanged: (e) {
                        _setUsername(e);
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      key: ObjectKey("$_loginPassword$_loginUsername-pass"),
                      autofocus: _loginPassword.isNotEmpty &&
                          _loginUsername.isNotEmpty,
                      initialValue: _loginPassword,
                      onChanged: (e) {
                        _setPassword(e);
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        MaterialButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          // style: ButtonStyle(
                          //     backgroundColor: _isMenuItemsOnly
                          //         ? MaterialStateProperty.all(Colors.red)
                          //         : MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            _registerUser(context);
                          },
                          child: const Text("Register"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
