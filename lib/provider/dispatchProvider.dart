import 'dart:convert';
import 'package:dispatch_app_rider/model/PlaceDistanceTime.dart';
import 'package:dispatch_app_rider/model/dispatch.dart';
import 'package:dispatch_app_rider/model/response.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'authProvider.dart';

Dispatch currentDispatch;
List<Dispatch> dispatchList;
String recieverPhone;
String recieverName;
final dispatchRef = FirebaseDatabase.instance.reference().child('dispatch');

class DispatchProvider with ChangeNotifier {
  Uuid uuid = Uuid();

  Future<ResponseModel> getDispatchList() async {
    dispatchList = dispatchList == null ? [] : dispatchList;
    List<Dispatch> alldispatch = [];
    try {
      dispatchList.clear();
      await dispatchRef
          .orderByChild("dispatchDate")
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> dbDispatchLIst = dataSnapshot.value;
        dbDispatchLIst.forEach((key, value) {
          final dispatch = Dispatch(
              id: value['id'],
              userId: value['userId'],
              trackingNo: value['trackingNo'],
              dispatchRiderId: value['dispatchRiderId'],
              dispatchDate: DateTime.parse(value['dispatchDate']),
              pickUpLocation: value['pickUpLocation'],
              dispatchDestination: value['dispatchDestination'],
              dispatchBaseFare:
                  double.parse(value['dispatchBaseFare'].toString()),
              dispatchTotalFare:
                  double.parse(value['dispatchTotalFare'].toString()),
              dispatchType: value['dispatchType'],
              dispatchStatus: value['dispatchStatus'],
              currentLocation: value['currentLocation'],
              estimatedDIspatchDuration: value['estimatedDIspatchDuration'],
              estimatedDistance: value['estimatedDistance'],
              dispatchReciever: value['dispatchReciever'],
              dispatchRecieverPhone: value['dispatchRecieverPhone']);
          alldispatch.add(dispatch);
        });
      });
      dispatchList = alldispatch.reversed.toList();
      return ResponseModel(true, "Disatch list gotten sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  List<Dispatch> getStreamDIspatchList(DataSnapshot dataSnapshot) {
    List<Dispatch> alldispatch = [];
    Map<dynamic, dynamic> dbDispatchLIst = dataSnapshot.value;
    dbDispatchLIst.forEach((key, value) {
      final dispatch = Dispatch(
          id: value['id'],
          userId: value['userId'],
          trackingNo: value['trackingNo'],
          dispatchRiderId: value['dispatchRiderId'],
          dispatchDate: DateTime.parse(value['dispatchDate']),
          pickUpLocation: value['pickUpLocation'],
          dispatchDestination: value['dispatchDestination'],
          dispatchBaseFare: double.parse(value['dispatchBaseFare'].toString()),
          dispatchTotalFare:
              double.parse(value['dispatchTotalFare'].toString()),
          dispatchType: value['dispatchType'],
          dispatchStatus: value['dispatchStatus'],
          currentLocation: value['currentLocation'],
          estimatedDIspatchDuration: value['estimatedDIspatchDuration'],
          estimatedDistance: value['estimatedDistance'],
          dispatchReciever: value['dispatchReciever'],
          dispatchRecieverPhone: value['dispatchRecieverPhone']);
      alldispatch.add(dispatch);
    });
    return alldispatch.reversed.toList();
  }

  List<Dispatch> getDispatchLIst(String dispatchStatus, List<Dispatch> list,
      {String riderId}) {
    var dispatchReturn = [];
    if (dispatchStatus == Constant.dispatchPendingStatus) {
      dispatchReturn = list
          .where((ds) => ds.dispatchStatus == Constant.dispatchPendingStatus)
          .toList();
      return dispatchReturn;
    }
    if (dispatchStatus == Constant.dispatchActiveStatus) {
      dispatchReturn = list
          .where((ds) =>
              ds.dispatchStatus == Constant.dispatchActiveStatus &&
              ds.dispatchRiderId == riderId)
          .toList();
      return dispatchReturn;
    }
    if (dispatchStatus == Constant.dispatchCompletedStatus) {
      dispatchReturn = list
          .where((ds) =>
              ds.dispatchStatus == Constant.dispatchCompletedStatus &&
              ds.dispatchRiderId == riderId)
          .toList();
      return dispatchReturn;
    }
    if (dispatchStatus == Constant.dispatchCancelledStatus) {
      dispatchReturn = list
          .where((ds) =>
              ds.dispatchStatus == Constant.dispatchCancelledStatus &&
              ds.dispatchRiderId == riderId)
          .toList();
      return dispatchReturn;
    }
    return dispatchReturn;
  }

  Future<PlaceDistanceTime> getPlaceDistanceTimeWithAddress(
      String origin, String destination, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json';
    String url =
        '$baseUrl?origins=$origin&destinations=$destination&key=${Constant.apiKey}&travelMode=driving&sessiontoken=$sessionToken';
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final PlaceDistanceTime placeDistanceTime =
        PlaceDistanceTime.fromJson(responseData);
    return placeDistanceTime;
  }

  Future<PlaceDistanceTime> getPlaceDistanceTimeWIthCordinate(
      LatLng origin, LatLng destination, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json';
    String url =
        '$baseUrl?origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=${Constant.apiKey}&travelMode=driving&sessiontoken=$sessionToken';
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final PlaceDistanceTime placeDistanceTime =
        PlaceDistanceTime.fromJson(responseData);
    return placeDistanceTime;
  }

  Future<ResponseModel> updateDispatchStatus(
      String dispatchId, String status) async {
    try {
      dispatchRef.child(dispatchId).update({'dispatchStatus': status});
      return ResponseModel(true, "Dispatch Staus Updated Sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  Future<ResponseModel> assignDispatchToRider(
      String dispatchId, String riderId) async {
    try {
      dispatchRef.child(dispatchId).update({
        'dispatchStatus': Constant.dispatchActiveStatus,
        "dispatchRiderId": riderId
      });
      return ResponseModel(true, "Dispatch Staus Updated Sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }
}
