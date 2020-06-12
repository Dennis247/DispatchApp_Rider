import 'package:dispatch_app_rider/ui/pages/dispatch/dispatchListPage.dart';
import 'package:dispatch_app_rider/ui/widgets/appDrawer.dart';
import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String routeName = "home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final TextStyle whiteText = TextStyle(color: Colors.white);

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
          value: count / 100,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "DISPATCH REPORT",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _buildStatusWidget("Pending Dispatch", 85, Colors.purple, context,
                () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DispatchList(
                        dispatchType: Constant.dispatchPendingStatus,
                      )));
            }),
            _buildStatusWidget("Active Dispatch", 50, Colors.green, context,
                () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DispatchList(
                        dispatchType: Constant.dispatchActiveStatus,
                      )));
            }),
            _buildStatusWidget("Completed Dispatch", 15, Colors.blue, context,
                () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DispatchList(
                        dispatchType: Constant.dispatchCompletedStatus,
                      )));
            }),
            _buildStatusWidget("Cancelled", 2, Colors.red, context, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DispatchList(
                        dispatchType: Constant.dispatchCancelledStatus,
                      )));
            }),
          ],
        ),
      ),
    );
  }
}
