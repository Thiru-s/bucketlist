import 'package:bucket_list_flutter/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class FirebaseMessageService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initFCM() async {
    await _requestPermissions();
    await _initLocalNotifications();

    // Get the token
   // String? token = await _messaging.getToken();
   // print('FCM Token: $token');
    fcmToken = await _messaging.getToken();

    print('fcmToken:$fcmToken');

    // Foreground message handling
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Background & terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOnMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _requestPermissions() async {
    await _messaging.requestPermission();
  }

  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        print("Notification tapped with payload: $payload");
        // You can handle navigation or other logic here
      },
    );

  }

  static void _handleForegroundMessage(RemoteMessage message) {
    print('Foreground Message: ${message.notification?.title}');
    _showLocalNotification(message);
  }

  static void _handleOnMessageOpenedApp(RemoteMessage message) {
    print('Notification tapped (onMessageOpenedApp): ${message.data}');
    // Handle navigation or other actions
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Background Message: ${message.notification?.title}');
    // You can optionally show a local notification
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformDetails,
    );
  }
}


/*
class FirebaseMsg{

  final msgService = FirebaseMessaging.instance;

  initFCM() async{
     await msgService.requestPermission();

     fcmToken = await msgService.getToken();

     print('FCMToken:$fcmToken');
     
     FirebaseMessaging.onBackgroundMessage(handleNotification);
     FirebaseMessaging.onMessage.listen(handleNotification);
  }
}

Future<void> handleNotification(RemoteMessage msg)async {

}*/
