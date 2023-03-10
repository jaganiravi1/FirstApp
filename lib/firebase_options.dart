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
    apiKey: 'AIzaSyDZxo7HHRGDSWycwsXXz6AyYsQlSfHaTnw',
    appId: '1:999871883811:web:4b621fca43e426c8ee9f96',
    messagingSenderId: '999871883811',
    projectId: 'application-5da77',
    authDomain: 'application-5da77.firebaseapp.com',
    databaseURL: 'https://application-5da77-default-rtdb.firebaseio.com',
    storageBucket: 'application-5da77.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6kREPOccLWuOZqBIoOW2Akn19t3Nx7Qw',
    appId: '1:999871883811:android:288725802d730b19ee9f96',
    messagingSenderId: '999871883811',
    projectId: 'application-5da77',
    databaseURL: 'https://application-5da77-default-rtdb.firebaseio.com',
    storageBucket: 'application-5da77.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAH1ZzOWCDjckFLEtORhspL2h3BbCZJUK8',
    appId: '1:999871883811:ios:6efa71b06239583dee9f96',
    messagingSenderId: '999871883811',
    projectId: 'application-5da77',
    databaseURL: 'https://application-5da77-default-rtdb.firebaseio.com',
    storageBucket: 'application-5da77.appspot.com',
    androidClientId: '999871883811-vjtvvcga7aqrqbcqfu63abgtj95rskvk.apps.googleusercontent.com',
    iosClientId: '999871883811-74gimncj0mha2l6l1859aiq1t7hnf9sv.apps.googleusercontent.com',
    iosBundleId: 'com.example.application',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAH1ZzOWCDjckFLEtORhspL2h3BbCZJUK8',
    appId: '1:999871883811:ios:6efa71b06239583dee9f96',
    messagingSenderId: '999871883811',
    projectId: 'application-5da77',
    databaseURL: 'https://application-5da77-default-rtdb.firebaseio.com',
    storageBucket: 'application-5da77.appspot.com',
    androidClientId: '999871883811-vjtvvcga7aqrqbcqfu63abgtj95rskvk.apps.googleusercontent.com',
    iosClientId: '999871883811-74gimncj0mha2l6l1859aiq1t7hnf9sv.apps.googleusercontent.com',
    iosBundleId: 'com.example.application',
  );
}
