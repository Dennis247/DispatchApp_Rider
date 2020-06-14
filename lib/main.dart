import 'package:dispatch_app_rider/provider/authProvider.dart';
import 'package:dispatch_app_rider/provider/dispatchProvider.dart';
import 'package:dispatch_app_rider/provider/notificatiomProvider.dart';
import 'package:dispatch_app_rider/ui/pages/auth/loginPage.dart';
import 'package:dispatch_app_rider/ui/pages/auth/signUpPage.dart';
import 'package:dispatch_app_rider/ui/pages/home/homePage.dart';
import 'package:dispatch_app_rider/ui/pages/notification/notificationPage.dart';
import 'package:dispatch_app_rider/ui/pages/onBoarding/OnBoardingPage.dart';
import 'package:dispatch_app_rider/ui/pages/settings/myProfilePage.dart';
import 'package:dispatch_app_rider/ui/pages/settings/settingsPage.dart';
import 'package:dispatch_app_rider/ui/pages/settings/updatePasswordPage.dart';
import 'package:dispatch_app_rider/ui/pages/support/supportPage.dart';
import 'package:dispatch_app_rider/ui/widgets/splashWidget.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'model/notification.dart';
import 'provider/googleMpaProvider.dart';
import 'utils/customRoute.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: GoogleMapProvider()),
          ChangeNotifierProvider.value(value: DispatchProvider()),
          ChangeNotifierProvider.value(value: AUthProvider()),
          ChangeNotifierProvider.value(value: NotificationProvider())
        ],
        child: Consumer<AUthProvider>(
          builder: (context, authData, _) {
            return MaterialApp(
              title: 'Dispatch App Rider',
              theme: ThemeData(
                  primaryColor: Constant.primaryColorDark,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                  })),
              home: authData.isLoggedIn
                  ? HomePage()
                  : FutureBuilder(
                      future: authData.tryAutoLogin(),
                      builder: (context, authDataResultSnapSHot) =>
                          authDataResultSnapSHot.connectionState ==
                                  ConnectionState.waiting
                              ? Center(
                                  child: SplashWidget(),
                                )
                              : authData.hasOnboarded
                                  ? LoginPage()
                                  : OnBoardingPage(),
                    ),
              routes: {
                LoginPage.routeName: (context) => LoginPage(),
                SignUpPage.routeName: (context) => SignUpPage(),
                HomePage.routeName: (context) => HomePage(),
                SupportPage.routeName: (context) => SupportPage(),
                SettingsPage.routeName: (context) => SettingsPage(),
                MyProfilePage.routeName: (context) => MyProfilePage(),
                UpdatePassowrd.routeName: (context) => UpdatePassowrd(),
                OnBoardingPage.routeName: (context) => OnBoardingPage(),
                NotificationPage.routeName: (context) => NotificationPage()
              },
            );
          },
        ));
  }
}
