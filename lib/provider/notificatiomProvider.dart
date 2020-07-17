import 'package:dispatch_app_rider/provider/authProvider.dart';
import 'package:dispatch_app_rider/src/lib_export.dart';

final notificationRef =
    FirebaseDatabase.instance.reference().child('notification');
final userRef = FirebaseDatabase.instance.reference().child('users');
final pickUpDetailRef =
    FirebaseDatabase.instance.reference().child('pickUpDetail');

class NotificationProvider with ChangeNotifier {
  void displayNotification(String title, String notificationMessage) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
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
            isNotificationSent: value['isNotificationSent'],
            isUserNotification: value['isUserNotification'],
            tokens: "");
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

  Future<void> createPickUpDetail(Dispatch dispatch) async {
    try {
      String userToken;
      //get user token and add to token array
      await userRef.child(dispatch.userId).once().then((dataSnapshot) {
        Map<dynamic, dynamic> snapSHotList = dataSnapshot.value;
        userToken = snapSHotList['token'];
      });
      PickUpDetail pickUpDetail = new PickUpDetail(
          id: Uuid().v4(),
          userId: dispatch.userId,
          riderId: loggedInRider.id,
          pickUpLocation: dispatch.pickUpLocation,
          dispatchDestination: dispatch.dispatchDestination,
          pickUpDate: DateTime.now());
      await pickUpDetailRef.child(pickUpDetail.id).set({
        "id": pickUpDetail.id,
        "userId": pickUpDetail.userId,
        "riderId": pickUpDetail.riderId,
        "pickUpLocation": pickUpDetail.pickUpLocation,
        "dispatchDestination": pickUpDetail.dispatchDestination,
        "pickUpDate": pickUpDetail.pickUpDate.toString(),
      });

      await createPickUpNotification(dispatch, userToken);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createPickUpNotification(
      Dispatch dispatch, String userToken) async {
    try {
      String tokenList = userToken + "," + loggedInRider.token;
      String notificationMessage = Constant.pickUpDispatchMessage
          .replaceAll("{{Rider}}", loggedInRider.fullName);

      final DispatchNotification dispatchNotification =
          new DispatchNotification(
              id: Uuid().v4(),
              message: notificationMessage,
              dispatchId: dispatch.id,
              userId: dispatch.userId,
              notificationType: Constant.pickUpDispatchNotification,
              pickUp: dispatch.pickUpLocation,
              notificationDate: DateTime.now(),
              recipientPhone: dispatch.dispatchRecieverPhone,
              isUserNotification: false,
              isNotificationSent: false,
              tokens: tokenList);
      await notificationRef.child(dispatchNotification.id).set({
        "id": dispatchNotification.id,
        "message": dispatchNotification.message,
        "dispatchId": dispatchNotification.dispatchId,
        "userId": dispatchNotification.userId,
        "notificationType": dispatchNotification.notificationType,
        "pickUp": dispatchNotification.pickUp,
        "recipientPhone": dispatchNotification.recipientPhone,
        "isNotificationSent": dispatchNotification.isNotificationSent,
        "isUserNotification": dispatchNotification.isUserNotification,
        "notificationDate": dispatchNotification.notificationDate.toString(),
        "tokens": dispatchNotification.tokens
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
