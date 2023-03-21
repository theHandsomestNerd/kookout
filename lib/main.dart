import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/pages/edit_profile_page.dart';
import 'package:chat_line/pages/home_page.dart';
import 'package:chat_line/pages/logout_page.dart';
import 'package:chat_line/pages/posts_thread_page.dart';
import 'package:chat_line/pages/profiles_page.dart';
import 'package:chat_line/pages/register_page.dart';
import 'package:chat_line/pages/solo_profile_page.dart';
import 'package:chat_line/platform_dependent/image_uploader_abstract.dart';
import 'package:chat_line/shared_components/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/firebase_options.dart';
import 'pages/login_page.dart';
import '../../platform_dependent/image_uploader.dart'
    if (dart.library.io) '../../platform_dependent/image_uploader_io.dart'
    if (dart.library.html) '../../platform_dependent/image_uploader_html.dart';

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
  ImageUploader imageUploader = ImageUploaderImpl();

  runApp(MyApp(
      authController: manager,
      drawer: globalDrawer,
      chatController: chatController,
      imageUploader: imageUploader));
}

class MyApp extends StatefulWidget {
  MyApp(
      {super.key,
      required this.authController,
      required this.imageUploader,
      required this.drawer,
      required this.chatController});

  final ImageUploader imageUploader;
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
        '/login': (context) => LoginPage(drawer: widget.drawer),
        '/editProfile': (context) => EditProfilePage(
              key: ObjectKey(widget.imageUploader.filename),
              imageUploader: widget.imageUploader,
              chatController: widget.chatController,
              authController: widget.authController,
              drawer: widget.drawer,
            ),
        '/logout': (context) => LogoutPage(drawer: widget.drawer),
        '/profilesPage': (context) => ProfilesPage(
            authController: widget.authController,
            chatController: widget.chatController,
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
        '/postsPage': (context) {
          return PostsThreadPage(
            chatController: widget.chatController,
            authController: widget.authController,
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
        primarySwatch: Colors.blue,
      ),
    );
  }
}
