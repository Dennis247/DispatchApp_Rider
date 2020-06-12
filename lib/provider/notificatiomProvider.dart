import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider with ChangeNotifier {
  FlutterLocalNotificationsPlugin flp;
  void initialisePushNotification() {
    flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
  }

  // void showNotification(String notificationMessage,FlutterLocalNotificationsPlugin  flp) async {
  //   var android = AndroidNotificationDetails(
  //       'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
  //       priority: Priority.High, importance: Importance.Max);
  //   var iOS = IOSNotificationDetails();
  //   var platform = NotificationDetails(android, iOS);
  //   await flp.show(0, notificationMessage, platform,
  //       payload: notificationMessage);
  // }

  void displayNotification(String title, String notificationMessage) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'dispatch notifications',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flp.show(0, title, notificationMessage, platformChannelSpecifics,
        payload: notificationMessage);
  }
}
