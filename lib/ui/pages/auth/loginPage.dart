import 'package:dispatch_app_rider/provider/authProvider.dart';
import 'package:dispatch_app_rider/provider/dispatchProvider.dart';
import 'package:dispatch_app_rider/provider/notificatiomProvider.dart';
import 'package:dispatch_app_rider/ui/pages/auth/signUpPage.dart';
import 'package:dispatch_app_rider/ui/pages/home/homePage.dart';
import 'package:dispatch_app_rider/ui/widgets/appButtonWidget.dart';
import 'package:dispatch_app_rider/ui/widgets/appInputWidget.dart';
import 'package:dispatch_app_rider/ui/widgets/appTextWidget.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = "loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  @override
  void initState() {
    Provider.of<NotificationProvider>(context, listen: false)
        .initialisePushNotification();

    //check onBoardingData
    _tryAutoLogin();
    super.initState();
  }

  void _tryAutoLogin() async {
    bool canAutoLogin =
        await Provider.of<AUthProvider>(context, listen: false).tryAutoLogin();
    if (canAutoLogin) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
  }

  void _loginUser() async {
    dispatchList = [];
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _startLoading(true);
    try {
      final response = await Provider.of<AUthProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text);
      if (response.isSUcessfull) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        _startLoading(false);
        Constant.showFialureDialogue(response.responseMessage, context);
      }
    } catch (e) {
      _startLoading(false);
      Constant.showFialureDialogue(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSzie = Constant.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    controller: _emailController,
                    validator: (value) {
                      return Constant.stringValidator(value, "email");
                    },
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: AppTextInputWIdget(
                      labelText: "password",
                      prefixIcon: FontAwesomeIcons.envelope,
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        return Constant.stringValidator(value, "password");
                      },
                    )),
                SizedBox(
                  height: appSzie.height * 0.05,
                ),
                _isLoading
                    ? Constant.circularInidcator()
                    : AppButtonWudget(
                        buttonText: "Login", function: _loginUser),
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
      ),
    );
  }
}
