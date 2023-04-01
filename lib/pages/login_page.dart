import 'package:chat_line/shared_components/logo.dart';
import 'package:chat_line/shared_components/menus/login_menu.dart';
import 'package:chat_line/wrappers/alerts_snackbar.dart';
import 'package:chat_line/wrappers/loading_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/controllers/auth_controller.dart';
import '../models/controllers/auth_inherited.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _loginUsername = "";
  String _loginPassword = "";
  AuthController? authController;
  final AlertSnackbar _alertSnackbar = AlertSnackbar();
bool isLoading = false;
  @override
  void initState() {
    super.initState();

    _loginPassword = '';
    _loginUsername = '';
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    authController = theAuthController;
    setState(() {});
    if (kDebugMode) {
      print("dependencies changed profile list");
    }
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

  void _loginUser(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginUsername,
        password: _loginPassword,
      );
      if (kDebugMode) {
        print(credential);
      }

      _alertSnackbar.showSuccessAlert(
          "${credential.user?.email ?? ""}Logged In", context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }

        _alertSnackbar.showSuccessAlert(
            "No user found for that email.", context);

        // Navigator.pushNamed(context, '/');
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        _alertSnackbar.showSuccessAlert(
            "Wrong password provided for that user.", context);

        // Navigator.pushNamed(context, '/');
      }
    }
    setState(() {
      isLoading = false;
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
      floatingActionButton: const LoginMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Logo(),
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
                                    isDisabled: _loginUsername.isEmpty || _loginPassword.isEmpty,
                                    action: () {
                                      _loginUser(context);
                                    },
                                    text: "Login",
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  const Text(
                                      "If you do not have an account..."),
                                  LoadingButton(
                                    isLoading: isLoading,
                                    action: () {
                                      Navigator.popAndPushNamed(
                                          context, '/register');
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
