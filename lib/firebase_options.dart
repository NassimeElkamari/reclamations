// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    apiKey: 'AIzaSyBumwDi6n0s9pTzCLOlynYpfA2OfQq1KhY',
    appId: '1:542494010671:web:c8199feb9eaf7c25e645da',
    messagingSenderId: '542494010671',
    projectId: 'final-pfe-project',
    authDomain: 'final-pfe-project.firebaseapp.com',
    storageBucket: 'final-pfe-project.appspot.com',
    measurementId: 'G-MC4176NCDB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuUe4qAerlbV9Nbhdk2LaSxmj0SDUveXo',
    appId: '1:542494010671:android:d0cdcc52b1b5a47fe645da',
    messagingSenderId: '542494010671',
    projectId: 'final-pfe-project',
    storageBucket: 'final-pfe-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhDptR-KK6QmuqXUuadpchOQpmUfXJOGE',
    appId: '1:542494010671:ios:dcb8d9f49c901bc8e645da',
    messagingSenderId: '542494010671',
    projectId: 'final-pfe-project',
    storageBucket: 'final-pfe-project.appspot.com',
    iosBundleId: 'com.example.applicationGestionDesReclamationsPfe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhDptR-KK6QmuqXUuadpchOQpmUfXJOGE',
    appId: '1:542494010671:ios:dcb8d9f49c901bc8e645da',
    messagingSenderId: '542494010671',
    projectId: 'final-pfe-project',
    storageBucket: 'final-pfe-project.appspot.com',
    iosBundleId: 'com.example.applicationGestionDesReclamationsPfe',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBumwDi6n0s9pTzCLOlynYpfA2OfQq1KhY',
    appId: '1:542494010671:web:fd985f0ded7e8003e645da',
    messagingSenderId: '542494010671',
    projectId: 'final-pfe-project',
    authDomain: 'final-pfe-project.firebaseapp.com',
    storageBucket: 'final-pfe-project.appspot.com',
    measurementId: 'G-M96C9898DC',
  );
}

class Notifications {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'fs_channel',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      await fln.show(id, title, body, platformChannelSpecifics);
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
}


class AccessTokenFirebase {
  static String firebaseMessagingScope = 'https://www.googleapis.com/auth/firebase.messaging';
  
  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": dotenv.env['FIREBASE_PROJECT_ID'],
          "private_key_id": dotenv.env['PRIVATE_KEY_ID'],
          "private_key": dotenv.env['PRIVATE_KEY'],
          "client_email": dotenv.env['CLIENT_EMAIL'],
          "client_id": dotenv.env['CLIENT_ID'],
          "auth_uri": dotenv.env['AUTH_URI'],
          "token_uri": dotenv.env['TOKEN_URI'],
          "auth_provider_x509_cert_url": dotenv.env['AUTH_PROVIDER_X509_CERT_URL'],
          "client_x509_cert_url": dotenv.env['CLIENT_X509_CERT_URL'],
          "universe_domain": dotenv.env['UNIVERSE_DOMAIN']
        },
      ),
      [firebaseMessagingScope]
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}