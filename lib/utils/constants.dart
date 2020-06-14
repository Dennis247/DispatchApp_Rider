import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'appStyles.dart';

class Constant {
  static Size getAppSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size;
  }

  static String stringValidator(String value, String controllerName) {
    if (value.isEmpty) {
      return "$controllerName cannot be empty";
    }
    return null;
  }

  static showFialureDialogue(String message, BuildContext context) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: false,
        //   title: 'Error',
        body: Column(
          children: <Widget>[
            Text(
              "Error",
              style: AppTextStyles.appDarkHeaderTextStyle,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.appTextStyle,
            )
          ],
        ),
        //  desc: message,
        btnOkOnPress: () {
          //  Navigator.of(context).pop();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Constant.primaryColorDark)
      ..show();
  }

  static showSuccessDialogue(String message, BuildContext context) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: false,
        // title: 'Error',
        body: Column(
          children: <Widget>[
            Text(
              "Sucess",
              style: AppTextStyles.appDarkHeaderTextStyle,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.appTextStyle,
            )
          ],
        ),
        //  desc: message,
        btnOkOnPress: () {
          //  Navigator.of(context).pop();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Constant.primaryColorDark)
      ..show();
  }

  // static showFialureDialogue(String message, BuildContext context) async {
  //   await showDialog(
  //       context: context,
  //       builder: (ctx) {
  //         return AlertDialog(
  //           title: Text(
  //             "Something went wrong",
  //             style: AppTextStyles.appTextStyle,
  //           ),
  //           content: Text(
  //             message,
  //             style: AppTextStyles.redlabelTextStyle,
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  // static showSuccessDialogue(String message, BuildContext context) async {
  //   await showDialog(
  //       context: context,
  //       builder: (ctx) {
  //         return AlertDialog(
  //           title: Text(
  //             "Operation Sucessfull",
  //             style: AppTextStyles.appTextStyle,
  //           ),
  //           content: Text(
  //             message,
  //             style: AppTextStyles.greenlabelTextStyle,
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  static Widget circularInidcator() {
    return JumpingText(
      "Loading...",
      style: AppTextStyles.appTextStyle,
    );
  }

  static Color primaryColorDark = Color(0xff0d1724);
  static Color primaryColorLight = Colors.white;

  static final String baseSearchUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  static final String apiKey = 'AIzaSyBaSy0NPJ63AzVrji8aIqYx0Ilwm1acUZw';
  static final String dispatchPendingStatus = "penidng";
  static final String dispatchActiveStatus = "active";
  static final String dispatchCompletedStatus = "completed";
  static final String dispatchCancelledStatus = "cancelled";
  static final String dispatchTypeEconomy = "Economy";
  static final String dispatchTypeExpress = "Express";
  static final String dispatchTypePremiun = "Premiun";
  static final double dispatchBaseFare = 500.00;
  static final String dispatchPickIpAddress = "18 Mushin Avenue Lagos";
  static final String dispatchDestinationAddress = "22 Yaba Education Centre";
  static final String pickUp = "PickUp Address";
  static final String deliveryAddress = "Delivery Address";
  static final String processDispatchMessage =
      "Your Request was sucessfull, Dispatch Rider is on the way for pick up";
  static final String cancellDispatchMessage =
      "Your Request was sucessfull, Your Dispatch has been Cancelled";
  static final String autoLogOnData = "auto log data";
  static final String onBoardingData = "on boarding data";
  static final String hiveData = "hive data";
  static final String userTypeUser = "user";
  static final String userTypeDriver = "driver";
  static final String pendingDispatchMessage = "Pick up is wwaiting at ";
  static final String completedDispatchMessage = "Dispatch Completed for  ";
  static final String pendingDispatchNotification = "pending dispatch";
  static final String completedDispatchNotification = "completed dispatch";
}
