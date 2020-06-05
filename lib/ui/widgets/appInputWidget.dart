import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTextInputWIdget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;

  const AppTextInputWIdget(
      {Key key, this.labelText, this.prefixIcon, this.obscureText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: Constant.primaryColorDark,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constant.primaryColorDark))),
      obscureText: obscureText,
    );
  }
}

class AppTextInputMultilineWIdget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;

  const AppTextInputMultilineWIdget(
      {Key key, this.labelText, this.prefixIcon, this.obscureText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: AppTextStyles.appTextStyle,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: Constant.primaryColorDark,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constant.primaryColorDark))),
      obscureText: obscureText,
    );
  }
}

class AppTextSmallInputWIdget extends StatelessWidget {
  final String labelText;
  final Widget prefixIcon;
  final bool obscureText;
  final Color prefixColor;
  final TextStyle labelTextSTyle;

  const AppTextSmallInputWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.prefixColor,
      this.labelTextSTyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelTextSTyle,
          prefixIcon: prefixIcon,
          suffix: Icon(
            Icons.close,
            color: Constant.primaryColorDark,
            size: 15,
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: obscureText,
    );
  }
}
