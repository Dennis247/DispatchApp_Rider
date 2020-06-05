import 'package:dispatch_app_rider/ui/widgets/DispatchListWidget.dart';
import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';

class DispatchList extends StatefulWidget {
  final String dispatchType;
  static final String routeName = "dispatch-list";

  const DispatchList({Key key, this.dispatchType}) : super(key: key);
  @override
  _DispatchListState createState() => _DispatchListState();
}

class _DispatchListState extends State<DispatchList> {
  @override
  Widget build(BuildContext context) {
    final appSize = Constant.getAppSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dispatchType,
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: appSize.height,
        width: appSize.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => DispatchListWidget()),
        ),
      ),
    );
  }
}
