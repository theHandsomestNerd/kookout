import 'package:cookout/models/controllers/auth_controller.dart';
import 'package:cookout/models/controllers/chat_controller.dart';
import 'package:cookout/models/controllers/post_controller.dart';
import 'package:cookout/pages/create_post_page.dart';
import 'package:cookout/pages/home_page.dart';
import 'package:cookout/pages/logout_page.dart';
import 'package:cookout/pages/posts_page.dart';
import 'package:cookout/pages/profiles_page.dart';
import 'package:cookout/pages/register_page.dart';
import 'package:cookout/pages/settings_page.dart';
import 'package:cookout/pages/solo_profile_page.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus_web/package_info_plus_web.dart';

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
    await FirebaseAuth.instance
        .useAuthEmulator('127.0.0.1', 9099); //Error is thrown here
    // FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
    // FirebaseDatabase.instance.useDatabaseEmulator('127.0.0.1', 9000);
    // await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
  }

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // AuthController manager = AuthController.init();

  runApp(const MyApp(
      // authController: manager,
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    // required this.authController,
  });

  // final AuthController authController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var authController = AuthController.init();
  var chatController = ChatController.init();
  var postController = PostController.init();
  var myAppUser = null;
  var myLoggedInUser = null;

  // var myExtProfile = null;

  bool isUserLoggedIn = false;

  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    // isUserLoggedIn = authController.isLoggedIn;

    // myExtProfile = chatController.myExtProfile;
    if (kDebugMode) {
      print("authcontroller myAppUser $myAppUser");

      print("authcontroller loggedinUSer $myLoggedInUser");
    }

    PackageInfoPlugin().getAll().then((packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  String id = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    var intermediate =
        AuthInherited.of(context)?.authController?.isLoggedIn ?? false;

    isUserLoggedIn = intermediate;
    // var profiles = await theChatController?.profileClient.fetchProfiles();
    // if (authController.myAppUser != null) {
    // myExtProfile = chatController
    //     .updateExtProfile(authController.myAppUser?.userId ?? "");
    // var theHighlightedProfile =
    //     await chatController.fetchHighlightedProfile();
    // highlightedProfile = theHighlightedProfile;
    // if (theHighlightedProfile?.userId != null) {
    //   var theExtProfile = await chatController.profileClient
    //       .getExtendedProfile(theHighlightedProfile?.userId ?? "");
    //   highlightedExtProfile = theExtProfile;
    // }
    // }
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthInherited(
      appName: appName,
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
      authController: authController,
      chatController: chatController,
      postController: postController,
      myLoggedInUser: authController.loggedInUser,
      profileImage: authController.myAppUser?.profileImage,
      child: MaterialApp(
        key: ObjectKey(isUserLoggedIn),
        title: 'Chat Line',
        routes: {
          '/home': (context) {
            return const HomePage();
          },
          '/postsPage': (context) => const PostsPage(),
          '/createPostsPage': (context) => const CreatePostPage(),
          '/register': (context) => RegisterPage(),
          '/': (context) => LoginPage(),
          // '/editProfile': (context) => const EditProfilePage(),
          '/logout': (context) => LogoutPage(),
          '/profilesPage': (context) => ProfilesPage(),
          '/profile': (context) {
            var arguments = (ModalRoute.of(context)?.settings.arguments ??
                <String, dynamic>{}) as Map;

            var theId;
            if (arguments['id'] != null) {
              theId = arguments['id'];
            } else {
              theId = authController.myAppUser?.userId.toString() ?? "";
            }

            var thisProfile = null;
            for (var element in chatController.profileList) {
              if (element.userId == theId) {
                thisProfile = element;
              }
            }

            return SoloProfilePage(
              thisProfile: thisProfile,
              key: ObjectKey(arguments["id"]),
              id: theId,
            );
          },
          '/myProfile': (context) {
            var theId = authController.myAppUser?.userId.toString() ?? "";
            var thisProfile = null;
            chatController.profileList.forEach((element) {
              if (element.userId == theId) {
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
            return const SettingsPage();
          },
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
            brightness: Brightness.light,
            accentColor: Colors.black,
          ),
          primaryColor: Colors.red,
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
            titleSmall: TextStyle(fontSize: 22.0),
            bodyLarge: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          // primarySwatch: Colors.grey,
        ),
      ),
    );
  }
}
