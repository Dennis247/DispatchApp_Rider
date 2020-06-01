import 'package:dispatch_app_rider/model/dispatch.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

Dispatch currentDispatch;

class DispatchProvider with ChangeNotifier {
  Uuid uuid = Uuid();
  Dispatch createDispatch(
      String dispatchType, String pickUpLocation, String dispatchDestination) {
    final Dispatch dispatch = new Dispatch(
        id: uuid.v4(),
        userId: null,
        dispatchNo: "DISP001",
        dispatchRiderId: uuid.v4(),
        dispatchDate: DateTime.now(),
        dispatchCompanyId: uuid.v4(),
        pickUpLocation: pickUpLocation,
        dispatchDestination: dispatchDestination,
        dispatchBaseFare: Constant.dispatchBaseFare,
        dispatchType: dispatchType,
        dispatchStatus: Constant.dispatchPendingStatus,
        lat: null,
        lng: null,
        estimatedDIspatchDuration: null,
        estimatedDistance: "40 KM",
        dispatchTotalFare: 5000,
        dispatchReciever: null,
        dispatchRecieverPhone: null);

    return dispatch;
  }
}
