import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/pages/edit_profile_page.dart';
import 'package:chat_line/pages/home_page.dart';
import 'package:chat_line/pages/logout_page.dart';
import 'package:chat_line/pages/profiles_page.dart';
import 'package:chat_line/pages/register_page.dart';
import 'package:chat_line/pages/solo_profile_page.dart';
import 'package:chat_line/shared_components/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/firebase_options.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // Ideal time to initialize

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  AuthController manager = AuthController.init();
  ChatController chatController = ChatController.init();
  Widget globalDrawer = AppDrawer(authController: manager);

  runApp(MyApp(
      authController: manager,
      drawer: globalDrawer,
      chatController: chatController));
}

class MyApp extends StatefulWidget {
  MyApp(
      {super.key,
      required this.authController,
      required this.drawer,
      required this.chatController});

  final AuthController authController;
  final ChatController chatController;
  final drawer;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: Key(widget.authController?.isLoggedIn.toString() ?? "-logged-in"),
      title: 'Chat Line',
      routes: {
        '/': (context) => HomePage(
            authController: widget.authController, drawer: widget.drawer),
        '/register': (context) => RegisterPage(
            authController: widget.authController, drawer: widget.drawer),
        '/login': (context) => LoginPage(
            authController: widget.authController, drawer: widget.drawer),
        '/editProfile': (context) => EditProfilePage(
            authController: widget.authController,
            drawer: widget.drawer,
            chatController: widget.chatController),
        '/logout': (context) => LogoutPage(
            authController: widget.authController, drawer: widget.drawer),
        '/loggedInHome': (context) => ProfilesPage(
            chatController: widget.chatController,
            authController: widget.authController,
            drawer: widget.drawer),
        '/profile': (context) {
          var arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;

          return SoloProfilePage(
            chatController: widget.chatController,
            authController: widget.authController,
            drawer: widget.drawer,
            id: arguments["id"] ?? "",
          );
        },
        '/myProfile': (context) {
          return SoloProfilePage(
            chatController: widget.chatController,
            authController: widget.authController,
            drawer: widget.drawer,
            id: widget.authController.myAppUser?.userId.toString() ?? "",
          );
        },
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}
