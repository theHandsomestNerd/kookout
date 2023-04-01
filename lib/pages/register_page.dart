import 'package:chat_line/wrappers/alerts_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/controllers/auth_inherited.dart';
import '../shared_components/app_drawer.dart';
import '../shared_components/menus/login_menu.dart';
import '../wrappers/loading_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

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

  bool isLoading = false;

  Future<void> _registerUser(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      // if (kDebugMode) {
      //   print("authcontroller ${AuthInherited.of(context)?.authController}");
      // }
      await AuthInherited.of(context)
          ?.authController
          ?.registerUser(_loginUsername, _loginPassword, context);
      // if (kDebugMode) {
      //   print(myAppUser);
      // }
      setState(() {
        isLoading = true;
      });
      Navigator.popAndPushNamed(context, '/settings');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        isLoading = true;
      });
    }

    AlertSnackbar().showSuccessAlert(
        'Account Created...Take a second to Fill in your profile.', context);

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
      floatingActionButton: const LoginMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset('assets/logo.png'),
        ),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/221.jpg',
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                              width: 300,
                              child: Image.asset('assets/logo.png'),
                            ),
                            SizedBox(
                              width: 350,
                              child: Column(
                                children: [
                                  TextFormField(
                                    autocorrect: false,
                                    initialValue: _loginUsername,
                                    onChanged: (e) {
                                      _setUsername(e);
                                    },
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white70,
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),
                                      labelText: 'Username',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    initialValue: _loginPassword,
                                    onChanged: (e) {
                                      _setPassword(e);
                                    },
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white70,
                                      prefixIcon: Icon(Icons.password),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),
                                      labelText: 'Password',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  LoadingButton(
                                    isLoading: isLoading,
                                    action: () {
                                      _registerUser(context);
                                    },
                                    text: "Register",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
