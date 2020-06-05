import 'package:dispatch_app_rider/ui/pages/auth/signUpPage.dart';
import 'package:dispatch_app_rider/ui/pages/home/homePage.dart';
import 'package:dispatch_app_rider/ui/widgets/appButtonWidget.dart';
import 'package:dispatch_app_rider/ui/widgets/appInputWidget.dart';
import 'package:dispatch_app_rider/ui/widgets/appTextWidget.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = "loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                scale: 1.5,
              ),
              SizedBox(
                height: appSzie.height * 0.04,
              ),
              Text.rich(
                AppTextWidget.appTextSpan("Login to ", "Easy Dispatch"),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: appSzie.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: AppTextInputWIdget(
                  labelText: "email",
                  prefixIcon: FontAwesomeIcons.user,
                  obscureText: false,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: AppTextInputWIdget(
                    labelText: "password",
                    prefixIcon: FontAwesomeIcons.envelope,
                    obscureText: true,
                  )),
              SizedBox(
                height: appSzie.height * 0.07,
              ),
              AppButtonWudget(
                buttonText: "Login",
                function: () {
                  Navigator.of(context).pushNamed(HomePage.routeName);
                },
              ),
              SizedBox(
                height: appSzie.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SignUpPage.routeName);
                },
                child: Text.rich(
                  AppTextWidget.appSmallTextSpan(
                      "Don't have an Account? ", "Sign Up"),
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
