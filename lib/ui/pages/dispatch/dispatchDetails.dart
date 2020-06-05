import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DispatchDetails extends StatelessWidget {
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
        SizedBox(
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildRowDetails(
                      Constant.pickUp, Constant.dispatchPickIpAddress),
                  Divider(),
                  _buildRowDetails(Constant.deliveryAddress,
                      Constant.dispatchDestinationAddress),
                  Divider(),
                  _buildRowDetails("Dispatch Type", "Economy"),
                  Divider(),
                  _buildRowDetails("Total Distance", "50 KM"),
                  Divider(),
                  _buildRowDetails2("Delivery Status", "DELIVERED",
                      Icons.cancel, "CANCEL", () {}),
                  Divider(),
                  _buildRowDetails2("current location", "52 Adesuwa Avenue",
                      FontAwesomeIcons.mapPin, "Map", () {}),
                  Divider(),
                  _buildRowDetails("Base Delivery Fee", "N 1000"),
                  Divider(),
                  _buildRowDetails("Total Delivery Fee", "N 5000"),
                  Divider(),
                  _buildRowDetails("Reciever Name", "Dennis Osagiede"),
                  Divider(),
                  _buildRowDetails("Reciever PhoneNumber", "08167828256"),
                  SizedBox(
                    height: appSzie.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
