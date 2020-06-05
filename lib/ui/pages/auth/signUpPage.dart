import 'package:dispatch_app_rider/ui/pages/home/homePage.dart';
import 'package:dispatch_app_rider/ui/widgets/appButtonWidget.dart';
import 'package:dispatch_app_rider/ui/widgets/appInputWidget.dart';
import 'package:dispatch_app_rider/ui/widgets/appTextWidget.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'loginPage.dart';

class SignUpPage extends StatelessWidget {
  static final String routeName = "signup-page";

  @override
  Widget build(BuildContext context) {
    final appSzie = Constant.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/on_the_way.png',
                scale: 2.5,
              ),
              SizedBox(
                height: appSzie.height * 0.03,
              ),
              Text.rich(
                AppTextWidget.appTextSpan("sign up on ", "Easy Dispatch"),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: appSzie.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: AppTextInputWIdget(
                  labelText: "full name",
                  prefixIcon: FontAwesomeIcons.user,
                  obscureText: false,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: AppTextInputWIdget(
                    labelText: "phone number",
                    prefixIcon: FontAwesomeIcons.phone,
                    obscureText: false,
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: AppTextInputWIdget(
                    labelText: "email",
                    prefixIcon: FontAwesomeIcons.envelope,
                    obscureText: false,
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: AppTextInputWIdget(
                    labelText: "password",
                    prefixIcon: FontAwesomeIcons.lock,
                    obscureText: true,
                  )),
              SizedBox(
                height: appSzie.height * 0.04,
              ),
              AppButtonWudget(
                buttonText: "Sign Up",
                function: () {
                  Navigator.of(context).pushNamed(HomePage.routeName);
                },
              ),
              SizedBox(
                height: appSzie.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginPage.routeName);
                },
                child: Text.rich(
                  AppTextWidget.appSmallTextSpan(
                      "already have an account? ", "Log In"),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
