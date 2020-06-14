import 'package:flutter/material.dart';

class DispatchNotification {
  final String id;
  final String message;
  final String dispatchId;
  final String userId;
  final String notificationType;
  final String pickUp;
  final DateTime notificationDate;
  final String recipientPhone;
  final bool isNotificationSent;

  DispatchNotification(
      {@required this.id,
      @required this.message,
      @required this.dispatchId,
      @required this.userId,
      @required this.notificationType,
      @required this.pickUp,
      @required this.recipientPhone,
      @required this.isNotificationSent,
      @required this.notificationDate});

  static List<DispatchNotification> nottificationtListFromJson(
      List collection) {
    List<DispatchNotification> notifications =
        collection.map((json) => DispatchNotification.fromJson(json)).toList();
    return notifications;
  }

  DispatchNotification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'],
        dispatchId = json['dispatchId'],
        userId = json['userId'],
        notificationType = json['notificationType'],
        pickUp = json['pickUp'],
        recipientPhone = json['recipientPhone'],
        isNotificationSent = json['isNotificationSent'],
        notificationDate = json['notificationDate'];
}
