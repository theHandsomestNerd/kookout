import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/pages/create_post_page.dart';
import 'package:chat_line/pages/home_page.dart';
import 'package:chat_line/pages/logout_page.dart';
import 'package:chat_line/pages/posts_page.dart';
import 'package:chat_line/pages/profiles_page.dart';
import 'package:chat_line/pages/register_page.dart';
import 'package:chat_line/pages/settings_page.dart';
import 'package:chat_line/pages/solo_profile_page.dart';
import 'package:chat_line/shared_components/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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

  if (kDebugMode) {
    //Emulator setup
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);  //Error is thrown here
    // FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
    // FirebaseDatabase.instance.useDatabaseEmulator('127.0.0.1', 9000);
    // await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
  }

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // AuthController manager = AuthController.init();
  ChatController chatController = ChatController.init();
  AppDrawer globalDrawer = const AppDrawer();

  runApp(MyApp(
    // authController: manager,
    drawer: globalDrawer,
    chatController: chatController,
  ));
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
  var myExtProfile = null;

  @override
  void initState() {
    super.initState();

    myExtProfile = chatController.myExtProfile;
    print("authcontroller myAppUser $myAppUser");
    print("authcontroller loggedinUSer $myLoggedInUser");
  }

  String id = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var theChatController = AuthInherited.of(context)?.chatController;

    myExtProfile = theChatController?.updateExtProfile(authController.myAppUser?.userId??"");

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthInherited(
      authController: authController,
      chatController: chatController,
      myLoggedInUser: authController.loggedInUser,
      profileImage: authController.myAppUser?.profileImage,
      child: MaterialApp(
        title: 'Chat Line',
        routes: {
          '/': (context) => HomePage(),
          '/postsPage':(context) => const PostsPage(),
          '/createPostsPage':(context) => const CreatePostPage(),
          '/register': (context) => RegisterPage(drawer: widget.drawer),
          '/login': (context) => LoginPage(drawer: widget.drawer),
          // '/editProfile': (context) => const EditProfilePage(),
          '/logout': (context) => LogoutPage(drawer: widget.drawer),
          '/profilesPage': (context) => ProfilesPage(drawer: widget.drawer),
          '/profile': (context) {
            var arguments = (ModalRoute.of(context)?.settings.arguments ??
                <String, dynamic>{}) as Map;

            var theId;
            if (arguments['id'] != null) {
              theId = arguments['id'];
            } else {
              theId = authController?.myAppUser?.userId.toString() ?? "";
            }
            print("The ID $theId");

            var thisProfile =null;
            chatController.profileList.forEach((element) {
                if(element.userId == theId) {
                  thisProfile = element;
                }
            });

            return SoloProfilePage(
              thisProfile: thisProfile,
              key: ObjectKey(arguments["id"]),
              id: theId,
            );
          },
          '/myProfile': (context) {
            var theId = authController?.myAppUser?.userId.toString() ?? "";
            var thisProfile =null;
            chatController.profileList.forEach((element) {
              if(element.userId == theId) {
                thisProfile = element;
              }
            });
            return SoloProfilePage(
              thisProfile: thisProfile,
              id: theId,
            );
          },
          // '/postsPage': (context) {
          //   return PostsThreadPage(
          //     drawer: widget.drawer,
          //   );
          // },
        '/settings': (context) {
            return SettingsPage();
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
            displayLarge:
                TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0),
            titleSmall: TextStyle(fontSize: 24.0),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
