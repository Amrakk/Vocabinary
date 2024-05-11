// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.get('WEB_API_KEY'),
    appId: '1:1097854412635:web:7374a8749b399f30441c7e',
    messagingSenderId: '1097854412635',
    projectId: 'vocabinary',
    authDomain: 'vocabinary.firebaseapp.com',
    storageBucket: 'vocabinary.appspot.com',
    measurementId: 'G-KHJBKKCMS3',

  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('ANDROID_API_KEY'),
    appId: '1:1097854412635:android:569b1554af30dc33441c7e',
    messagingSenderId: '1097854412635',
    projectId: 'vocabinary',
    storageBucket: 'vocabinary.appspot.com',
  );
}
