// ignore_for_file: prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20commune/logo.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Home_enseignant.dart';

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:application_gestion_des_reclamations_pfe/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Correct import
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDuUe4qAerlbV9Nbhdk2LaSxmj0SDUveXo",
      appId: "1:542494010671:android:d0cdcc52b1b5a47fe645da",
      messagingSenderId: "542494010671",
      projectId: "final-pfe-project",
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Notifications.initialize(flutterLocalNotificationsPlugin);
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   @override
  void initState() {
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Request the FCM token and print it
    messaging.getToken().then((token) {
      print('FCM Token*****************************************************: $token');
    }).catchError((e) {
      print('Error getting FCM token: $e');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        Notifications.showBigTextNotification(
          id: notification.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          fln: flutterLocalNotificationsPlugin,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Welcome': (context) => WelcomeScreen(),
        '/loginetudiant': (context) => Login(),
        // 'HomeEnseignant': (context) => HomeEnseignant(),
        //'LoginEnseignant': (context) => SignInEnseignant(),
        //'HomeEtudiant': (context) => NavigatorBarEtudiant(),
      },
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: LogoScreen(),
    );
  }
}
