import 'package:cookout/config/default_config.dart';
import 'package:cookout/shared_components/logo.dart';
import 'package:cookout/shared_components/menus/login_menu.dart';
import 'package:cookout/wrappers/alerts_snackbar.dart';
import 'package:cookout/wrappers/loading_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/controllers/auth_controller.dart';
import '../models/controllers/auth_inherited.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;
  String _loginUsername = "";
  String _loginPassword = "";
  late AuthController authController;
  final AlertSnackbar _alertSnackbar = AlertSnackbar();
  bool isLoading = false;
  late String sanityDB;
  late String apiVersion;
  late String sanityApiDB;

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
        AuthInherited
            .of(context)
            ?.authController;
    if (theAuthController != null) {
      authController = theAuthController;
    }

    apiVersion = DefaultConfig.apiVersion ?? "no version";
    sanityApiDB = DefaultConfig.apiSanityDB ?? "no api env";
    setState(() {});
    if (kDebugMode) {
      print("dependencies changed login page");
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

  String? errorText = null;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      floatingActionButton: LoginMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Logo(),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            child: Center(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/221.jpg',
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
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
                                      autofocus: _loginPassword.isEmpty,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          errorText = "Cant be empty.";
                                          return 'Can\'t be empty';
                                        }
                                        if (text.length < 4) {
                                          errorText = "Too short.";
                                          return 'Too short';
                                        }
                                        return null;
                                      },
                                      autocorrect: false,
                                      initialValue: _loginUsername,
                                      onChanged: (e) {
                                        _setUsername(e);
                                      },
                                      decoration: InputDecoration(
                                        helperText: errorText,
                                        filled: true,
                                        fillColor: Colors.white70,
                                        prefixIcon: const Icon(Icons.person),
                                        border: const OutlineInputBorder(
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
                                      isDisabled: _loginUsername.isEmpty ||
                                          _loginPassword.isEmpty,
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
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 32.0),
                          child: Column(
                            children: [
                              Text(
                                  "${DefaultConfig.appName} v${DefaultConfig.version}.${DefaultConfig
                                      .buildNumber} - ${DefaultConfig.sanityDB}"),
                              Text("api v${apiVersion} -${sanityApiDB}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
