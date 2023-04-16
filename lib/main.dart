import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:th_flutter/routes/routes.dart';
import 'package:th_flutter/screen/home/notification_fragment.dart';
import 'package:th_flutter/screen/splash_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Fluttertoast? flutterToast;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.instance
      .getToken()
      .then((value) => {print("get token: $value")});

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    (RemoteMessage message) async {
      print("openMessageOpenedApp: $message");
      Navigator.pushNamed(navigatorKey.currentState!.context, NotificationDetail.routeName,
          arguments: {"message": json.encode(message.data)});
    };
  });

  FirebaseMessaging.instance.getInitialMessage().then((value) => {
        (RemoteMessage message) async {
          if (message != null) {
            Navigator.pushNamed(
                navigatorKey.currentState!.context, NotificationDetail.routeName,
                arguments: {"message": json.encode(message.data)});
          }
        }
      });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  await OneSignal.shared.setAppId("95e65145-2b37-4da7-aa7d-d3a540a418b9");
  await OneSignal.shared.getDeviceState().then((value) =>
  {
    print(value!.userId)
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler((
      OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((
      OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared.setSubscriptionObserver((
      OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver((
      OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });

  flutterToast = Fluttertoast();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();

  print("_firebaseMessagingBackgroundHandler: $message");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      routes: routes,
      home: const SplashPage(),
    );
  }
}
