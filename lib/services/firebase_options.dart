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
    apiKey: 'AIzaSyDEMpIdkDqNUdruIBFjMGFyLZPyTQij8sE',
    appId: '1:1071276849732:web:57aa3adf896d445be39a11',
    messagingSenderId: '1071276849732',
    projectId: 'filmfolio-609db',
    authDomain: 'filmfolio-609db.firebaseapp.com',
    storageBucket: 'filmfolio-609db.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVBlEQdcWniYm2VNaTLnWcRYLk38ol6Ew',
    appId: '1:1071276849732:android:3ecdb11008bf74dae39a11',
    messagingSenderId: '1071276849732',
    projectId: 'filmfolio-609db',
    storageBucket: 'filmfolio-609db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8EWazjOwhjsEjj-geLdq3mt3WMigbbak',
    appId: '1:1071276849732:ios:851ba64bbd3dc81de39a11',
    messagingSenderId: '1071276849732',
    projectId: 'filmfolio-609db',
    storageBucket: 'filmfolio-609db.appspot.com',
    iosBundleId: 'com.example.filmfolio',
  );
}
