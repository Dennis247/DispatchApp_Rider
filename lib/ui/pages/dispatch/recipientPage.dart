// import 'package:dispatch_app_client/ui/pages/auth/signUpPage.dart';
// import 'package:dispatch_app_client/ui/pages/dispatch/confirmDispatch.dart';
// import 'package:dispatch_app_client/ui/pages/home/homePage.dart';
// import 'package:dispatch_app_client/ui/widgets/appButtonWidget.dart';
// import 'package:dispatch_app_client/ui/widgets/appInputWidget.dart';
// import 'package:dispatch_app_client/ui/widgets/appLogo.dart';
// import 'package:dispatch_app_client/ui/widgets/appTextWidget.dart';
// import 'package:dispatch_app_client/utils/appStyles.dart';
// import 'package:dispatch_app_client/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

// class RecipientPage extends StatefulWidget {
//   static final String routeName = "recipient-page";

//   @override
//   _RecipientPageState createState() => _RecipientPageState();
// }

// class _RecipientPageState extends State<RecipientPage> {
//   @override
//   Widget build(BuildContext context) {
//     final appSzie = Constant.getAppSize(context);
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Stack(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Image.asset(
//                     'assets/images/recipient.png',
//                     scale: 1.5,
//                   ),
//                   SizedBox(
//                     height: appSzie.height * 0.04,
//                   ),
//                   Text.rich(
//                     AppTextWidget.appTextSpan("enter ", "Reciver Details"),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: appSzie.height * 0.03,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15, right: 15),
//                     child: AppTextInputWIdget(
//                       labelText: "Name",
//                       prefixIcon: FontAwesomeIcons.user,
//                       obscureText: false,
//                     ),
//                   ),
//                   Padding(
//                       padding:
//                           const EdgeInsets.only(left: 15, right: 15, top: 10),
//                       child: AppTextInputWIdget(
//                         labelText: "Phone",
//                         prefixIcon: FontAwesomeIcons.phone,
//                         obscureText: false,
//                       )),
//                   SizedBox(
//                     height: appSzie.height * 0.07,
//                   ),
//                   AppButtonWudget(
//                     buttonText: "PROCEED",
//                     function: () {
//                       Navigator.of(context)
//                           .pushNamed(ConfirmDispatch.routeName);
//                     },
//                   ),
//                   SizedBox(
//                     height: appSzie.height * 0.03,
//                   ),
//                 ],
//               ),
//               Positioned(
//                 top: 15.0,
//                 left: 10.0,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: IconButton(
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         color: Constant.primaryColorDark,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
