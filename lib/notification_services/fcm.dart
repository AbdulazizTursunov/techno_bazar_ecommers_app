import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/model/local_database.dart';
import 'package:untitled10/model/noti_model.dart';
import 'package:untitled10/notification_services/local_notification.dart';
import 'package:untitled10/provider/providerFcmLocal.dart';

Future<void> initFirebase(BuildContext context) async {
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.subscribeToTopic("news");

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

//FOREGROUND APP ICHIDAGI HOLAT
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    LocalNotificationService.instance.showFlutterNotification(remoteMessage);
    debugPrint(
        "FCM foreground message ${remoteMessage.notification}  va  ${remoteMessage.data["body"]} ");

    LocalDatabase.insertNews(NewsModel.fromJson(remoteMessage.data));
    context.read<ProviderFcm>().readNewsNotification();
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHendling);

  //terminate mode handling notification

  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  _handleMessage(RemoteMessage messages) {
    debugPrint(
        "FCM terminated message ${messages.notification}  va  ${messages.data["custom_field"]} ");
    LocalNotificationService.instance.showFlutterNotification(messages);
  }

  if (message != null) {
    _handleMessage(message);
    LocalDatabase.insertNews(NewsModel.fromJson(message.data));
    if (context.mounted) context.read<ProviderFcm>().readNewsNotification();
  }

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

Future<void> _firebaseBackgroundHendling(RemoteMessage remoteMessages) async {
  await Firebase.initializeApp();
  LocalDatabase.insertNews(NewsModel.fromJson(remoteMessages.data));
  debugPrint(
      "FCM background message ${remoteMessages.notification!}  va  ${remoteMessages.data["custom_field"]} ");
}
