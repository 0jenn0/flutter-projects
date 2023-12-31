// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCawhqoZ4PQ_JUtOuCHDZvOnILroTWSBLo',
    appId: '1:471255930862:web:8835c12f449c1ed32c60ff',
    messagingSenderId: '471255930862',
    projectId: 'fluttergram-c2af5',
    authDomain: 'fluttergram-c2af5.firebaseapp.com',
    storageBucket: 'fluttergram-c2af5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6e1aeSKkmjVnFqjGS9eng3IrmYuUWKt8',
    appId: '1:471255930862:android:ec8c961cd690135a2c60ff',
    messagingSenderId: '471255930862',
    projectId: 'fluttergram-c2af5',
    storageBucket: 'fluttergram-c2af5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoilcf6BPTa94Lep7pLhBf2ll2VzA_JH4',
    appId: '1:471255930862:ios:4ac0d071c0779df42c60ff',
    messagingSenderId: '471255930862',
    projectId: 'fluttergram-c2af5',
    storageBucket: 'fluttergram-c2af5.appspot.com',
    iosClientId: '471255930862-18u2el6mqhfccj4lrmhkd6d9advseuc1.apps.googleusercontent.com',
    iosBundleId: 'com.example.insta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBoilcf6BPTa94Lep7pLhBf2ll2VzA_JH4',
    appId: '1:471255930862:ios:1439b12ba674e5252c60ff',
    messagingSenderId: '471255930862',
    projectId: 'fluttergram-c2af5',
    storageBucket: 'fluttergram-c2af5.appspot.com',
    iosClientId: '471255930862-5g73pd469c0r6g908rj7aceat6cfbf8g.apps.googleusercontent.com',
    iosBundleId: 'com.example.insta.RunnerTests',
  );
}
