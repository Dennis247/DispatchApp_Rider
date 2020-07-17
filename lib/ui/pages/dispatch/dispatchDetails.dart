import 'package:dispatch_app_rider/provider/authProvider.dart';
import 'package:dispatch_app_rider/provider/dispatchProvider.dart';
import 'package:dispatch_app_rider/provider/notificatiomProvider.dart';
import 'package:dispatch_app_rider/ui/pages/home/homePage.dart';
import 'package:dispatch_app_rider/ui/widgets/appButtonWidget.dart';
import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'dispatchLocation.dart';
import 'dispatchStausPage.dart';
import 'package:dispatch_app_rider/src/lib_export.dart';

class DispatchDetails extends StatefulWidget {
  final Dispatch dispatch;
  const DispatchDetails({Key key, this.dispatch}) : super(key: key);

  @override
  _DispatchDetailsState createState() => _DispatchDetailsState();
}

class _DispatchDetailsState extends State<DispatchDetails> {
  bool _isLoading = false;

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  _buildRowDetails(String title, String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.smallgreyTextStyle,
        ),
        Text(
          subTitle,
          style: AppTextStyles.appTextStyle,
        ),
      ],
    );
  }

  _buildRowDetails2(String title, String subTitle, IconData iconData,
      String iconTitle, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextStyles.smallgreyTextStyle,
              ),
              Text(
                subTitle,
                style: AppTextStyles.appTextStyle,
              ),
            ],
          ),
        ),
        _showCancelMapButton() == true
            ? SizedBox(
                width: 100,
                child: RaisedButton.icon(
                    color: Constant.primaryColorDark,
                    shape: StadiumBorder(),
                    onPressed: function,
                    icon: Icon(
                      iconData,
                      size: 16,
                      color: Constant.primaryColorLight,
                    ),
                    label: Text(
                      iconTitle,
                      style: AppTextStyles.smallWhiteTextStyle,
                    )),
              )
            : Text("")
      ],
    );
  }

  _showCancelMapButton() {
    if (widget.dispatch.dispatchStatus == Constant.dispatchCompletedStatus ||
        widget.dispatch.dispatchStatus == Constant.dispatchCancelledStatus ||
        widget.dispatch.dispatchStatus == Constant.dispatchPendingStatus)
      return false;
    return true;
  }

  _showCurrentLocation() {
    if (widget.dispatch.dispatchStatus == Constant.dispatchCompletedStatus ||
        widget.dispatch.dispatchStatus == Constant.dispatchCancelledStatus ||
        widget.dispatch.dispatchStatus == Constant.dispatchPendingStatus)
      return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final dispatchProvider =
        Provider.of<DispatchProvider>(context, listen: false);
    final appSzie = Constant.getAppSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DISPATCH DETAILS",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: appSzie.height,
        width: appSzie.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildRowDetails("Pick Up", widget.dispatch.pickUpLocation),
                Divider(),
                _buildRowDetails(
                    "Delivery Location", widget.dispatch.dispatchDestination),
                Divider(),
                _buildRowDetails("Dispatch Type", widget.dispatch.dispatchType),
                Divider(),
                _buildRowDetails(
                    "Total Distance", widget.dispatch.estimatedDistance),
                Divider(),
                _isLoading
                    ? Constant.circularInidcator()
                    : _buildRowDetails2(
                        "Delivery Status",
                        widget.dispatch.dispatchStatus,
                        Icons.cancel,
                        "CANCEL", () async {
                        _startLoading(true);
                        final response = await Provider.of<DispatchProvider>(
                                context,
                                listen: false)
                            .updateDispatchStatus(widget.dispatch.id,
                                Constant.dispatchCancelledStatus);
                        if (response.isSUcessfull == true) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => DispatchStatus(
                                        dispatchMessage:
                                            Constant.cancellDispatchMessage,
                                        imageUrl: "assets/images/premiun.png",
                                        isDispatchProcessing: false,
                                      )),
                              (Route<dynamic> route) => false);
                        } else {
                          _startLoading(false);
                          Constant.showFialureDialogue(
                              response.responseMessage, context);
                        }
                      }),
                _showCurrentLocation() ? Divider() : SizedBox(),
                _showCurrentLocation()
                    ? _buildRowDetails2(
                        "current location",
                        widget.dispatch.currentLocation,
                        FontAwesomeIcons.mapPin,
                        "Map", () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DispatchLocation()));
                      })
                    : SizedBox(),
                Divider(),
                _buildRowDetails("Base Delivery Fee",
                    widget.dispatch.dispatchBaseFare.toString()),
                Divider(),
                _buildRowDetails("Total Delivery Fee",
                    widget.dispatch.dispatchTotalFare.toString()),
                Divider(),
                _buildRowDetails(
                    "Reciever Name", widget.dispatch.dispatchReciever),
                Divider(),
                _buildRowDetails("Reciever PhoneNumber",
                    widget.dispatch.dispatchRecieverPhone),
                SizedBox(
                  height: appSzie.height * 0.03,
                ),
                SizedBox(
                  height: appSzie.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: _isLoading
              ? Constant.circularInidcator()
              : AppRectButtonWidget(
                  width: appSzie.width,
                  buttonText: "ACCEPT DISPATCH",
                  function: () async {
                    _startLoading(true);
                    //set dispatch status to active and set dispatatch to rider Id
                    final ResponseModel responseModel =
                        await dispatchProvider.assignDispatchToRider(
                            widget.dispatch.id, loggedInRider.id);
                    if (!responseModel.isSUcessfull) {
                      Constant.showFialureDialogue(
                          responseModel.responseMessage, context);
                      return;
                    } else {
                      Provider.of<NotificationProvider>(context, listen: false)
                          .displayNotification("Dispatch Accepted",
                              "Dispatch Delivery for ${widget.dispatch.dispatchReciever}\n(${widget.dispatch.dispatchRecieverPhone})\naccepted by ${loggedInRider.fullName}");
                      //send local notification to deliver dispatch
                      //send user the notification that rider si coming for pick up
                      Provider.of<NotificationProvider>(context, listen: false)
                          .createPickUpDetail(widget.dispatch);
                    }
                    _startLoading(false);
                    //goto dashboard
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false);
                  },
                ),
        ),
      ),
    );
  }
}
