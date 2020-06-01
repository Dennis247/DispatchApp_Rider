import 'package:flutter/material.dart';

class Dispatch {
  final String id;
  final String userId;
  final String dispatchNo;
  final String dispatchRiderId;
  final DateTime dispatchDate;
  final String dispatchCompanyId;
  final String pickUpLocation;
  final String dispatchDestination;
  final double dispatchBaseFare;
  final double dispatchTotalFare;
  final String dispatchType;
  final String dispatchStatus;
  final double lat;
  final double lng;
  final String estimatedDIspatchDuration;
  final String estimatedDistance;
  final String dispatchReciever;
  final String dispatchRecieverPhone;

  Dispatch(
      {@required this.id,
      @required this.userId,
      @required this.dispatchNo,
      @required this.dispatchRiderId,
      @required this.dispatchDate,
      @required this.dispatchCompanyId,
      @required this.pickUpLocation,
      @required this.dispatchDestination,
      @required this.dispatchBaseFare,
      @required this.dispatchTotalFare,
      @required this.dispatchType,
      @required this.dispatchStatus,
      @required this.lat,
      @required this.lng,
      @required this.estimatedDIspatchDuration,
      @required this.estimatedDistance,
      @required this.dispatchReciever,
      @required this.dispatchRecieverPhone});
}
