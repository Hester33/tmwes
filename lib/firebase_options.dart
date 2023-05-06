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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgqIyv4ycG6DCezOlc-VmsTwM0TydvpNU',
    appId: '1:518803896548:android:d7d350d12ac7b0dcfb14f1',
    messagingSenderId: '518803896548',
    projectId: 'tmwes-73322',
    storageBucket: 'tmwes-73322.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD465Ndb8Q6yTJ08tszAl-QZjlAYfOfw4Q',
    appId: '1:518803896548:ios:cb49027794bf361efb14f1',
    messagingSenderId: '518803896548',
    projectId: 'tmwes-73322',
    storageBucket: 'tmwes-73322.appspot.com',
    androidClientId:
        '518803896548-aij2bafrhg6r4l913qnqmq6q4hg5sod1.apps.googleusercontent.com',
    iosClientId:
        '518803896548-ucs2mqsf1mudijt55u2690dqq7o2l337.apps.googleusercontent.com',
    iosBundleId: 'com.example.tmwes',
  );
}
