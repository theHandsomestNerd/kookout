import 'dart:js_util';

import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/pages/edit_profile_page.dart';
import 'package:chat_line/pages/home_page.dart';
import 'package:chat_line/pages/logout_page.dart';
import 'package:chat_line/pages/posts_thread_page.dart';
import 'package:chat_line/pages/profiles_page.dart';
import 'package:chat_line/pages/register_page.dart';
import 'package:chat_line/pages/solo_profile_page.dart';
import 'package:chat_line/shared_components/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/firebase_options.dart';
import 'models/controllers/auth_inherited.dart';
import 'pages/login_page.dart';
// import '../../platform_dependent/image_uploader.dart'
//     if (dart.library.io) '../../platform_dependent/image_uploader_io.dart'
//     if (dart.library.html) '../../platform_dependent/image_uploader_html.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // Ideal time to initialize

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // AuthController manager = AuthController.init();
  ChatController chatController = ChatController.init();
  AppDrawer globalDrawer = AppDrawer();

  runApp(MyApp(
      // authController: manager,
      drawer: globalDrawer,
      chatController: chatController,));
}

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      // required this.authController,
      required this.drawer,
      required this.chatController});

  // final AuthController authController;
  final ChatController chatController;
  final AppDrawer drawer;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var authController = AuthController.init();
  var chatController = ChatController.init();
  var myAppUser = null;
  var myLoggedInUser = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("authcontroller myAppUser $myAppUser");
    print("authcontroller loggedinUSer $myLoggedInUser");
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthInherited(
      authController: authController,
      chatController: chatController,
      myAppUser: authController.myAppUser,
      myLoggedInUser: authController.loggedInUser,
      profileImage: authController.myAppUser?.profileImage,
      child: MaterialApp(
        title: 'Chat Line',
        routes: {
          '/': (context) => HomePage(
              drawer: widget.drawer),
          '/register': (context) => RegisterPage(
              drawer: widget.drawer),
          '/login': (context) => LoginPage(drawer: widget.drawer),
          '/editProfile': (context) => EditProfilePage(
                extProfile: chatController.myExtProfile,
                // key: ObjectKey(widget.imageUploader.file?.name),
                // imageUploader: widget.imageUploader,
                drawer: widget.drawer,
              ),
          '/logout': (context) => LogoutPage(drawer: widget.drawer),
          '/profilesPage': (context) => ProfilesPage(
              drawer: widget.drawer),
          '/profile': (context) {
            var arguments = (ModalRoute.of(context)?.settings.arguments ??
                <String, dynamic>{}) as Map;

            return SoloProfilePage(
              key: ObjectKey(arguments["id"]),
              drawer: widget.drawer,
              id: arguments["id"] ?? "",
            );
          },
          '/myProfile': (context) {
            return SoloProfilePage(
              drawer: widget.drawer,
              id: AuthInherited.of(context)?.authController?.myAppUser?.userId.toString() ?? "",
            );
          },
          '/postsPage': (context) {
            return PostsThreadPage(
              drawer: widget.drawer,
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
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
