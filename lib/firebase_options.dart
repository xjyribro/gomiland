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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCgEUQVlqq3lmv5upDRFo5CMCO4BfRC6i4',
    appId: '1:303826100020:web:dd5e52220d457fac7e4f61',
    messagingSenderId: '303826100020',
    projectId: 'gomiland-d19db',
    authDomain: 'gomiland-d19db.firebaseapp.com',
    storageBucket: 'gomiland-d19db.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdKYDK0iYp2x1W4XevqqKnTn7ySHgQQn8',
    appId: '1:303826100020:android:6e24d2445dd10e917e4f61',
    messagingSenderId: '303826100020',
    projectId: 'gomiland-d19db',
    storageBucket: 'gomiland-d19db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7tigwewAcC5crixB35raw2ESkCS5Z0jc',
    appId: '1:303826100020:ios:6d69f2fc42ff0a5e7e4f61',
    messagingSenderId: '303826100020',
    projectId: 'gomiland-d19db',
    storageBucket: 'gomiland-d19db.appspot.com',
    androidClientId: '303826100020-13ctmc3tpjrli332f7rm9mu1dehgv67e.apps.googleusercontent.com',
    iosClientId: '303826100020-o0lst15lm59vjsut09c14gs65ptcom18.apps.googleusercontent.com',
    iosBundleId: 'com.gomiland.gomiland',
  );
}