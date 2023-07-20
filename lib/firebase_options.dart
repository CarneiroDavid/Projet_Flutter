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
    apiKey: 'AIzaSyAnTqMT1kghr3zgr-JxPq951r4UO7mEwjU',
    appId: '1:250755581486:web:29d8879d61a524880781bf',
    messagingSenderId: '250755581486',
    projectId: 'testprojet-4d89e',
    authDomain: 'testprojet-4d89e.firebaseapp.com',
    storageBucket: 'testprojet-4d89e.appspot.com',
    measurementId: 'G-2HDYXTBHFW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBLK7RXGQ6vE_H51bs3yklVMwKWg6pBdA',
    appId: '1:250755581486:android:f6ab28a09dd96d540781bf',
    messagingSenderId: '250755581486',
    projectId: 'testprojet-4d89e',
    storageBucket: 'testprojet-4d89e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_CJXCFfkUsMAeksUa8OKzo7dnTvjcXtQ',
    appId: '1:250755581486:ios:0cb125675bf76e930781bf',
    messagingSenderId: '250755581486',
    projectId: 'testprojet-4d89e',
    storageBucket: 'testprojet-4d89e.appspot.com',
    iosClientId: '250755581486-d6jc4tm7jsmi51hc15c68t6vhvu00vsq.apps.googleusercontent.com',
    iosBundleId: 'com.light.ipssisqy2023',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_CJXCFfkUsMAeksUa8OKzo7dnTvjcXtQ',
    appId: '1:250755581486:ios:0cb125675bf76e930781bf',
    messagingSenderId: '250755581486',
    projectId: 'testprojet-4d89e',
    storageBucket: 'testprojet-4d89e.appspot.com',
    iosClientId: '250755581486-d6jc4tm7jsmi51hc15c68t6vhvu00vsq.apps.googleusercontent.com',
    iosBundleId: 'com.light.ipssisqy2023',
  );
}