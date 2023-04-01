// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:chat_line/config/app_options.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultAppOptions {
  static AppOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const AppOptions local = AppOptions(
    blankUrl: "https://placeimg.com/640/480/any",
    sanityDB: "production",
    imageAssetPrefix: "assets/",
    authBaseUrl:
        'http://127.0.0.1:5001/the-handsomest-nerd-auth/us-central1/app',
  );

  static const AppOptions macos = AppOptions(
    sanityDB: "production",
    blankUrl: "https://placeimg.com/640/480/any",
    imageAssetPrefix: "assets/",
    authBaseUrl:
        'http://127.0.0.1:5001/the-handsomest-nerd-auth/us-central1/app',
  );

  static const AppOptions web = AppOptions(
    sanityDB: "production",
    imageAssetPrefix: "assets/",
    blankUrl: "",
    // blankUrl: "https://placeimg.com/640/480/any",
    // authBaseUrl: 'https://us-central1-the-handsomest-nerd-auth.cloudfunctions.net/app',
    authBaseUrl:
        'http://127.0.0.1:5001/the-handsomest-nerd-auth/us-central1/app',
  );

  static const AppOptions android = AppOptions(
    imageAssetPrefix: "assets/",
    sanityDB: "production",
    blankUrl: "https://placeimg.com/640/480/any",
    authBaseUrl:
        'http://127.0.0.1:5001/the-handsomest-nerd-auth/us-central1/app',
  );

  static const AppOptions ios = AppOptions(
    imageAssetPrefix: "assets/",
    sanityDB: "production",
    blankUrl: "https://placeimg.com/640/480/any",
    authBaseUrl:
        'http://127.0.0.1:5001/the-handsomest-nerd-auth/us-central1/app',
  );

// static const FirebaseOptions android = FirebaseOptions(
//   apiKey: 'AIzaSyC5FkJAr9E4EmbMjKZNuTmG7eFWQJk8Y-8',
//   appId: '1:853598734701:android:c6f4eac320608c54177264',
//   messagingSenderId: '853598734701',
//   projectId: 'the-handsomest-nerd-auth',
//   storageBucket: 'the-handsomest-nerd-auth.appspot.com',
// );
//
// static const FirebaseOptions ios = FirebaseOptions(
//   apiKey: 'AIzaSyBBk1hBMrUPxW3dItdxDQxURHE413eSmkI',
//   appId: '1:853598734701:ios:4b3e26f0eb239c01177264',
//   messagingSenderId: '853598734701',
//   projectId: 'the-handsomest-nerd-auth',
//   storageBucket: 'the-handsomest-nerd-auth.appspot.com',
//   iosClientId: '853598734701-b9vf3cj8hp91ov2692hflju16dbb4rt6.apps.googleusercontent.com',
//   iosBundleId: 'com.thehandsomestnerd.chatLine',
// );
//
// static const FirebaseOptions macos = FirebaseOptions(
//   apiKey: 'AIzaSyBBk1hBMrUPxW3dItdxDQxURHE413eSmkI',
//   appId: '1:853598734701:ios:4b3e26f0eb239c01177264',
//   messagingSenderId: '853598734701',
//   projectId: 'the-handsomest-nerd-auth',
//   storageBucket: 'the-handsomest-nerd-auth.appspot.com',
//   iosClientId: '853598734701-b9vf3cj8hp91ov2692hflju16dbb4rt6.apps.googleusercontent.com',
//   iosBundleId: 'com.thehandsomestnerd.chatLine',
// );
}
