import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/location/widget/widget_map_type.dart';

import '../../../google_map_provider/map_provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key, required this.latLong});

  final LatLng latLong;

  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  late Completer<GoogleMapController> _controller;
  MapType type = MapType.hybrid;

  late CameraPosition initialCameraPosition;


  @override
  void initState() {
    initialCameraPosition = CameraPosition(target: widget.latLong, zoom: 15);
    _controller =  Completer<GoogleMapController>();
    Future.delayed(Duration(seconds: 0));


    super.initState();
  }


  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
  }

  _setMarker() {
    return const Marker(
      markerId: MarkerId("marker_1"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.43296265331129, -122.08832357078792),
    );
  }

  @override
  Widget build(BuildContext context) {
    type = context.watch<MapProvider>().type;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          GoogleMap(
            markers: <Marker>{_setMarker()},
            mapType:type,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
       const   Positioned(
            left: 15,bottom: 80,
            child: SelectedMayType(),
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _goToTheLake,
          child:const Center(
            child:  Icon(
              Icons.location_searching_outlined,
            ),
          ),
        ),
      ),
    );
  }


}
