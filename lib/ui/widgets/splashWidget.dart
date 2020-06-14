import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Constant.circularInidcator(),
        ),
      ),
    );
  }
}
