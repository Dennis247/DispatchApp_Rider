import 'package:flutter/material.dart';

class Constant {
  static Size getAppSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size;
  }

  static Color primaryColorDark = Color(0xff0d1724);
  static Color primaryColorLight = Colors.white;

  static final String baseSearchUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  static final String apiKey = 'AIzaSyCDJa_D_Ewcm8wE8OAH6uBQttSxALdoNUI';
  static final String dispatchPendingStatus = "Pending Dispatch";
  static final String dispatchActiveStatus = "Active Dispatch";
  static final String dispatchCompletedStatus = "Completed Dispatch";
  static final String dispatchCancelledStatus = "Cancelled Dispatch";
  static final String dispatchTypeEconomy = "Economy";
  static final String dispatchTypeExpress = "Express";
  static final String dispatchTypePremiun = "Premiun";
  static final double dispatchBaseFare = 500.00;
  static final String dispatchPickIpAddress = "18 Mushin Avenue Lagos";
  static final String dispatchDestinationAddress = "22 Yaba Education Centre";
  static final String pickUp = "PickUp Address";
  static final String deliveryAddress = "Delivery Address";
}
