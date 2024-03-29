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
    apiKey: 'AIzaSyAKg10LA2FlDURODmS1QOgzjra5dc_xPn0',
    appId: '1:162292952427:web:61358b6cd5c83a2b24302e',
    messagingSenderId: '162292952427',
    projectId: 'chartlytics-image-picker',
    authDomain: 'chartlytics-image-picker.firebaseapp.com',
    storageBucket: 'chartlytics-image-picker.appspot.com',
    measurementId: 'G-QJ46BX6S6Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzgPUr7awzxh4w9jV-4vioA_BITtNhYgU',
    appId: '1:162292952427:android:50dd854de93eb50924302e',
    messagingSenderId: '162292952427',
    projectId: 'chartlytics-image-picker',
    storageBucket: 'chartlytics-image-picker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7LjW43BQ3x2pul74jra4Hg0EGbFOycOU',
    appId: '1:162292952427:ios:658968308f789f6c24302e',
    messagingSenderId: '162292952427',
    projectId: 'chartlytics-image-picker',
    storageBucket: 'chartlytics-image-picker.appspot.com',
    iosClientId: '162292952427-8g6uhll7l0dhnbtcs0r2b6h15ca7esfk.apps.googleusercontent.com',
    iosBundleId: 'com.example.pickImage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7LjW43BQ3x2pul74jra4Hg0EGbFOycOU',
    appId: '1:162292952427:ios:658968308f789f6c24302e',
    messagingSenderId: '162292952427',
    projectId: 'chartlytics-image-picker',
    storageBucket: 'chartlytics-image-picker.appspot.com',
    iosClientId: '162292952427-8g6uhll7l0dhnbtcs0r2b6h15ca7esfk.apps.googleusercontent.com',
    iosBundleId: 'com.example.pickImage',
  );
}
