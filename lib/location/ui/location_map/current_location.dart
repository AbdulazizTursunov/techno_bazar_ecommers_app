import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../tab_box/google_map_screen/user_location.dart';


class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  LatLng? latLong;

  Future<void> _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      latLong = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    });
  }

  _init() async {
    await _getLocation();

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted&&latLong!=null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return GoogleMapScreen(
          latLong: latLong!,
        );
      }));
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Icon(Icons.location_on_sharp,size: 200,),
        ),
      )
    );
  }
}

// Center(
// child: Text("Splash Screen:${latLong?.longitude}  and ${latLong?.latitude}  "),
// ),