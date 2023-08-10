import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';


class LocalNotificationService{

  LocalNotificationService._();
  static LocalNotificationService instance= LocalNotificationService._();

  factory LocalNotificationService()=>instance;

  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotifInitialized = false;

  Future<void> setupLocalNotification() async {
    if (isFlutterLocalNotifInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
        "high_importance_channel",
        "High Importance Notification",
        description: "This channel local Notification.",
        importance: Importance.high);



    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);


    isFlutterLocalNotifInitialized = true;
  }

  void showFlutterNotification(RemoteMessage remoteMessagesLocal) {
    RemoteNotification? remoteNotification = remoteMessagesLocal.notification;
    AndroidNotification? androidNotification = remoteMessagesLocal.notification?.android;

    if(remoteNotification != null && androidNotification != null && !kIsWeb){
      flutterLocalNotificationsPlugin.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: "launch_background"
              )
          )
      );
    }
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
}