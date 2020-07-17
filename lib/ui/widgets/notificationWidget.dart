import 'package:dispatch_app_rider/model/notification.dart';
import 'package:dispatch_app_rider/provider/dispatchProvider.dart';
import 'package:dispatch_app_rider/ui/pages/dispatch/dispatchDetails.dart';
import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:dispatch_app_rider/src/lib_export.dart';

class NotificationWidget extends StatelessWidget {
  final DispatchNotification dispatchNotification;
  const NotificationWidget({Key key, this.dispatchNotification})
      : super(key: key);
  _buildRideInfo(
    String point,
    String title,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.bell,
              size: 22,
              color: color,
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$point', style: AppTextStyles.smallgreyTextStyle),
              Text(
                title,
                style: AppTextStyles.appTextStyle,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildBottomInfo(IconData iconData, String title, Color statusColor) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: 20,
          color: statusColor,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: AppTextStyles.smallgreyTextStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dispatch = dispatchList
        .firstWhere((ds) => ds.id == dispatchNotification.dispatchId);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DispatchDetails(
            dispatch: dispatch,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        child: Card(
          shadowColor: Constant.primaryColorDark,
          elevation: 2,
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: _buildRideInfo(
                          dispatchNotification.notificationType,
                          dispatchNotification.pickUp,
                          Colors.red),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildBottomInfo(
                            Icons.phone,
                            dispatchNotification.recipientPhone,
                            Constant.primaryColorDark),
                        _buildBottomInfo(
                            FontAwesomeIcons.clock,
                            timeago
                                .format(dispatchNotification.notificationDate),
                            Constant.primaryColorDark)
                      ],
                    ),
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 125,
          ),
        ),
      ),
    );
  }
}
