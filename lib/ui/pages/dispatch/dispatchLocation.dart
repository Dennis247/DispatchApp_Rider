import 'dart:async';
import 'package:dispatch_app_rider/provider/googleMpaProvider.dart';
import 'package:dispatch_app_rider/ui/widgets/appDrawer.dart';
import 'package:dispatch_app_rider/utils/appStyles.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:dispatch_app_rider/src/lib_export.dart';

class DispatchLocation extends StatefulWidget {
  static final routeName = "dispatch-location";
  @override
  _DispatchLocationState createState() => _DispatchLocationState();
}

class _DispatchLocationState extends State<DispatchLocation> {
  LatLng myLocation = LatLng(6.5244, 3.3792);
  Completer<GoogleMapController> _controller = Completer();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _fromLocationController = TextEditingController();
  TextEditingController _toLocationController = TextEditingController();
  BitmapDescriptor _start;
  BitmapDescriptor _end;
  PlaceDetail _startPlaceDetail = new PlaceDetail();
  PlaceDetail _endPlaceDetail = new PlaceDetail();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  bool _hasGottenCordinates = false;
  bool _isAutoSuggestedDone = false;
  String _dispatchStartAddress = "";
  String _dispatchEndAddress = "";

  Set<Marker> _markers = {};
  LatLngBounds bound;
  var uuid = Uuid();
  String _mapStyle;
  var sessionToken;
  int _selectedIdnex = -1;
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/start.png')
        .then((onValue) {
      _start = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/end.png')
        .then((onValue) {
      _end = onValue;
    });

    rootBundle.loadString('assets/images/map_style.txt').then((string) {
      _mapStyle = string;
    });
    super.initState();
  }

  void _getLatLngBounds(LatLng from, LatLng to) {
    if (from.latitude > to.latitude && from.longitude > to.longitude) {
      bound = LatLngBounds(southwest: to, northeast: from);
    } else if (from.longitude > to.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(from.latitude, to.longitude),
          northeast: LatLng(to.latitude, from.longitude));
    } else if (from.latitude > to.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(to.latitude, from.longitude),
          northeast: LatLng(from.latitude, to.longitude));
    } else {
      bound = LatLngBounds(southwest: from, northeast: to);
    }
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  void _clearCordinate() {
    setState(() {
      _fromLocationController.clear();
      _toLocationController.clear();
      _hasGottenCordinates = false;
      _polylines = {};
      _markers.clear();
    });
  }

  setPolylines() async {
    polylineCoordinates.clear();
    _polylines.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constant.apiKey,
        PointLatLng(_startPlaceDetail.lat, _startPlaceDetail.lng),
        PointLatLng(_endPlaceDetail.lat, _endPlaceDetail.lng),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Constant.primaryColorDark,
          width: 4,
          points: polylineCoordinates);
      _polylines.add(polyline);
      _hasGottenCordinates = true;
    });
  }

  void _moveCamera() async {
    if (_markers.length > 0) {
      setState(() {
        _markers.clear();
      });
    }
    if (_toLocationController.text != "" &&
        _fromLocationController.text != "") {
      _getLatLngBounds(LatLng(_startPlaceDetail.lat, _startPlaceDetail.lng),
          LatLng(_endPlaceDetail.lat, _endPlaceDetail.lng));
      GoogleMapController controller = await _controller.future;
      CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
      controller.animateCamera(u2).then((void v) {
        check(u2, controller);
      });
    }

    setState(() {
      if (_fromLocationController.text != "" && _startPlaceDetail != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(_startPlaceDetail.placeId),
            position: LatLng(_startPlaceDetail.lat, _startPlaceDetail.lng),
            icon: _start,
            infoWindow: InfoWindow(
              title: "pick up",
              snippet: _dispatchStartAddress,
            ),
          ),
        );
      }

      if (_toLocationController.text != "" && _endPlaceDetail != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(_endPlaceDetail.placeId),
            position: LatLng(_endPlaceDetail.lat, _endPlaceDetail.lng),
            icon: _end,
            infoWindow: InfoWindow(
              title: "destination",
              snippet: _dispatchEndAddress,
            ),
          ),
        );
      }
    });

    if (_toLocationController.text != "" &&
        _endPlaceDetail != null &&
        _fromLocationController.text != "" &&
        _startPlaceDetail != null) {
      await setPolylines();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSize = Constant.getAppSize(context);
    final googleMapProvider =
        Provider.of<GoogleMapProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "CURRENT LOCATION",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        key: _scaffoldKey,
        drawer: AppDrawer(),
        body: Container(
          width: appSize.width,
          height: appSize.height,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            markers: _markers,
            polylines: _polylines,
            initialCameraPosition: CameraPosition(target: myLocation, zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}
