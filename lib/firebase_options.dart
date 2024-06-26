// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBUznibAZeu023hPt7-L38Kvf2ICvddxyw',
    appId: '1:925184093809:web:7e2a69c45348dfc51035d0',
    messagingSenderId: '925184093809',
    projectId: 'esource-bed3f',
    authDomain: 'esource-bed3f.firebaseapp.com',
    storageBucket: 'esource-bed3f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuAvFnpuWHXt73hjSga0cxxnXiPyzY5vo',
    appId: '1:925184093809:android:e4648a74bb8b45561035d0',
    messagingSenderId: '925184093809',
    projectId: 'esource-bed3f',
    storageBucket: 'esource-bed3f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnBUcQ3WbqLkONZ5frlDwjr4xvY6jh3UI',
    appId: '1:925184093809:ios:7ad046b1eafdae001035d0',
    messagingSenderId: '925184093809',
    projectId: 'esource-bed3f',
    storageBucket: 'esource-bed3f.appspot.com',
    iosBundleId: 'com.example.esource',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnBUcQ3WbqLkONZ5frlDwjr4xvY6jh3UI',
    appId: '1:925184093809:ios:7ad046b1eafdae001035d0',
    messagingSenderId: '925184093809',
    projectId: 'esource-bed3f',
    storageBucket: 'esource-bed3f.appspot.com',
    iosBundleId: 'com.example.esource',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUznibAZeu023hPt7-L38Kvf2ICvddxyw',
    appId: '1:925184093809:web:8204e69c4df46ec61035d0',
    messagingSenderId: '925184093809',
    projectId: 'esource-bed3f',
    authDomain: 'esource-bed3f.firebaseapp.com',
    storageBucket: 'esource-bed3f.appspot.com',
  );
}
