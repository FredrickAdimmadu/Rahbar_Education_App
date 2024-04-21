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
    apiKey: 'AIzaSyBemMtrqT18GajPReL9tCADs9BoB-Rh3js',
    appId: '1:421199461075:web:1461e5ff2ec277c755b226',
    messagingSenderId: '421199461075',
    projectId: 'fivum-73ed0',
    authDomain: 'fivum-73ed0.firebaseapp.com',
    databaseURL: 'https://fivum-73ed0-default-rtdb.firebaseio.com',
    storageBucket: 'fivum-73ed0.appspot.com',
    measurementId: 'G-38BSJNDG8K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFL0_YZGwdsiuY-ld50UlVo0hFFVOl1ac',
    appId: '1:421199461075:android:64a40d93bf23396755b226',
    messagingSenderId: '421199461075',
    projectId: 'fivum-73ed0',
    databaseURL: 'https://fivum-73ed0-default-rtdb.firebaseio.com',
    storageBucket: 'fivum-73ed0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmOuLqJtI4AmWBl7gPIhbCCDY4SrkaZ9s',
    appId: '1:421199461075:ios:56ae9ad3398a2aab55b226',
    messagingSenderId: '421199461075',
    projectId: 'fivum-73ed0',
    databaseURL: 'https://fivum-73ed0-default-rtdb.firebaseio.com',
    storageBucket: 'fivum-73ed0.appspot.com',
    iosBundleId: 'com.example.rahbar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmOuLqJtI4AmWBl7gPIhbCCDY4SrkaZ9s',
    appId: '1:421199461075:ios:a1a040a56756683455b226',
    messagingSenderId: '421199461075',
    projectId: 'fivum-73ed0',
    databaseURL: 'https://fivum-73ed0-default-rtdb.firebaseio.com',
    storageBucket: 'fivum-73ed0.appspot.com',
    iosBundleId: 'com.example.rahbar.RunnerTests',
  );
}