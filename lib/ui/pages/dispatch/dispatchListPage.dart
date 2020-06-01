// import 'package:dispatch_app_client/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DispatchListPage extends StatelessWidget {
//   static final String routeName = "dispatch-list";
//   @override
//   Widget build(BuildContext context) {
//     final appSize = Constant.getAppSize(context);
//     return Scaffold(
//       body: Container(
//         height: appSize.height,
//         width: appSize.width,
//         child: ListView.builder(
//             itemCount: 10, itemBuilder: (context, index) => BookingCard()),
//       ),
//     );
//   }
// }

// class BookingCard extends StatelessWidget {
//   @override
//   const BookingCard();

//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Padding(
//         padding: new EdgeInsets.symmetric(vertical: 3.0),
//         child: new Card(
//           elevation: 3,
//           child: new Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: new Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                   new Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         new Expanded(
//                           child: new Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Material(
//                                   color: Colors.green[500],
//                                   shape: StadiumBorder(),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "ACTIVE",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 )
//                               ]),
//                         ),
//                         new Text(
//                           "12/12/12",
//                           style: new TextStyle(
//                               color: Colors.black, fontSize: 14.0),
//                         ),
//                       ]),
//                   new Container(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: new Column(children: <Widget>[
//                         new Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               CircleAvatar(
//                                 backgroundColor: Colors.deepOrange,
//                                 radius: 13.0,
//                                 child: Icon(
//                                   FontAwesomeIcons.hourglassStart,
//                                   size: 12.0,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 3.0,
//                               ),
//                               Expanded(
//                                   child: new Row(children: <Widget>[
//                                 new Text(
//                                   "booking.pickupLocation",
//                                   style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 13.0,
//                                   ),
//                                 ),
//                               ])),
//                             ]),
//                         SizedBox(height: 10.0),
//                         new Row(children: <Widget>[
//                           CircleAvatar(
//                             backgroundColor: Colors.deepPurple,
//                             radius: 13.0,
//                             child: Icon(
//                               FontAwesomeIcons.mapMarkerAlt,
//                               size: 12.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 3.0,
//                           ),
//                           new Text(
//                             "booking.deliveryLocation",
//                             style: new TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 13.0),
//                           ),
//                         ])
//                       ])),
//                   new Row(children: <Widget>[
//                     new Expanded(
//                         child: new Container(
//                             child: new Row(children: <Widget>[
//                       new Icon(
//                         Icons.timer,
//                         color: Colors.black,
//                       ),
//                       new Text("booking.deliverytime",
//                           style: new TextStyle(
//                               color: Colors.black, fontSize: 14.0)),
//                       SizedBox(width: 25.0),
//                       new Icon(FontAwesomeIcons.truck, color: Colors.black),
//                       SizedBox(width: 5.0),
//                       new Text("truck.truckName",
//                           style: new TextStyle(
//                               color: Colors.black, fontSize: 14.0)),
//                     ]))),
//                     new Icon(Icons.directions, color: Colors.black),
//                     new Text("booking.trackingNumber",
//                         style:
//                             new TextStyle(color: Colors.black, fontSize: 14.0)),
//                   ])
//                 ])
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
