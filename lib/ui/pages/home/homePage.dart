import 'package:dispatch_app_rider/provider/authProvider.dart';
import 'package:dispatch_app_rider/provider/dispatchProvider.dart';
import 'package:dispatch_app_rider/ui/pages/dispatch/dispatchListPage.dart';
import 'package:dispatch_app_rider/ui/widgets/appDrawer.dart';
import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dispatch_app_rider/src/lib_export.dart';

class HomePage extends StatelessWidget {
  static final String routeName = "home-page";
  _buildStatusWidget(String subject, int count, Color color,
      BuildContext context, Function function) {
    return Card(
      child: ListTile(
        onTap: function,
        title: Text(
          subject,
          style: AppTextStyles.appTextStyle,
        ),
        subtitle: LinearProgressIndicator(
          value: count / 10,
          valueColor: AlwaysStoppedAnimation(color),
          backgroundColor: Colors.grey,
        ),
        trailing: Text(
          "$count",
          style: AppTextStyles.appTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Dispatch> _pendingDisaptchlist = [];
    List<Dispatch> _activeDispatchList = [];
    List<Dispatch> _completedDispatchList = [];
    List<Dispatch> _cancelledDisaptchList = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "DISPATCH BOARD",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
          stream: dispatchRef.orderByChild('dispatchDate').onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Constant.circularInidcator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "An Error Occured loading Dispatch List",
                    style: AppTextStyles.appTextStyle,
                  ),
                );
              } else {
                final dispatchProvider =
                    Provider.of<DispatchProvider>(context, listen: false);
                List<Dispatch> loadedDispatch = dispatchProvider
                    .getStreamDIspatchList(snapshot.data.snapshot);
                dispatchList = loadedDispatch;
                _pendingDisaptchlist = dispatchProvider.getDispatchLIst(
                    Constant.dispatchPendingStatus, dispatchList);
                _activeDispatchList = dispatchProvider.getDispatchLIst(
                    Constant.dispatchActiveStatus, dispatchList,
                    riderId: loggedInRider.id);
                _completedDispatchList = dispatchProvider.getDispatchLIst(
                    Constant.dispatchCompletedStatus, dispatchList,
                    riderId: loggedInRider.id);
                _cancelledDisaptchList = dispatchProvider.getDispatchLIst(
                    Constant.dispatchCancelledStatus, dispatchList,
                    riderId: loggedInRider.id);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      _buildStatusWidget(
                          "Pending Dispatch",
                          _pendingDisaptchlist.length,
                          Colors.purple,
                          context, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DispatchList(
                                  dispatchType: Constant.dispatchPendingStatus,
                                  dispatchList: _pendingDisaptchlist,
                                )));
                      }),
                      _buildStatusWidget(
                          "Active Dispatch",
                          _activeDispatchList.length,
                          Colors.green,
                          context, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DispatchList(
                                  dispatchType: Constant.dispatchActiveStatus,
                                  dispatchList: _activeDispatchList,
                                )));
                      }),
                      _buildStatusWidget(
                          "Completed Dispatch",
                          _completedDispatchList.length,
                          Colors.blue,
                          context, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DispatchList(
                                  dispatchType:
                                      Constant.dispatchCompletedStatus,
                                  dispatchList: _completedDispatchList,
                                )));
                      }),
                      _buildStatusWidget(
                          "Cancelled",
                          _cancelledDisaptchList.length,
                          Colors.red,
                          context, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DispatchList(
                                  dispatchType:
                                      Constant.dispatchCancelledStatus,
                                  dispatchList: _cancelledDisaptchList,
                                )));
                      }),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }
}
