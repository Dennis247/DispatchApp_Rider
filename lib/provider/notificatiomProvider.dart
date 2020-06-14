import 'package:dispatch_app_rider/model/notification.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notificationRef =
    FirebaseDatabase.instance.reference().child('notification');

FlutterLocalNotificationsPlugin flp;

class NotificationProvider with ChangeNotifier {
  void initialisePushNotification() {
    flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
  }

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

  List<DispatchNotification> getStreamNotificationhList(
      DataSnapshot dataSnapshot) {
    List<DispatchNotification> allNotification = [];
    Map<dynamic, dynamic> dbNotificationLIst = dataSnapshot.value;
    if (dataSnapshot.value != null) {
      dbNotificationLIst.forEach((key, value) {
        final notification = DispatchNotification(
            id: value['id'],
            message: value['message'],
            dispatchId: value['dispatchId'],
            userId: value['userId'],
            notificationType: value['notificationType'],
            pickUp: value['pickUp'],
            recipientPhone: value['recipientPhone'],
            notificationDate: DateTime.parse(value['notificationDate']),
            isNotificationSent: value['isNotificationSent']);
        allNotification.add(notification);
      });
      return allNotification.reversed.toList();
    }
    return List<DispatchNotification>();
  }

  checkSendPendingNotification(List<DispatchNotification> notificationList) {
    try {
      notificationList.forEach((nf) {
        if (!nf.isNotificationSent &&
            nf.notificationType == Constant.pendingDispatchNotification) {
          //send pending dispatch to all riders
          displayNotification("Pending Dispatch", nf.message);
          //update notification as sent
          notificationRef.child(nf.id).update({'isNotificationSent': true});
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
