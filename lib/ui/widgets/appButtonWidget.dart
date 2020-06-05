import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtonWudget extends StatelessWidget {
  final String buttonText;
  final Function function;

  const AppButtonWudget({Key key, this.buttonText, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = Constant.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Constant.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        width: appSzie.width * 0.8,
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: Constant.primaryColorDark,
        ),
      ),
    );
  }
}

class AppSmallButtonWudget extends StatelessWidget {
  final String buttonText;
  final Function function;

  const AppSmallButtonWudget({Key key, this.buttonText, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = Constant.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Constant.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        width: appSzie.width * 0.5,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: Constant.primaryColorDark,
        ),
      ),
    );
  }
}
