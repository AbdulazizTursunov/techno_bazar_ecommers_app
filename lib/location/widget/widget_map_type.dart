import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../google_map_provider/map_provider.dart';

class SelectedMayType extends StatefulWidget {
  const SelectedMayType({Key? key}) : super(key: key);

  @override
  State<SelectedMayType> createState() => _SelectedMayTypeState();
}

class _SelectedMayTypeState extends State<SelectedMayType> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.menu,size: 50,color: Colors.blue,),
      onSelected: (value) {

        context.read<MapProvider>().mapType(value as MapType);
      },
      itemBuilder: (BuildContext bc) {
        return const [
          PopupMenuItem(
            child: Text("none"),
            value: MapType.none,
          ),
          PopupMenuItem(
            child: Text("normal"),
            value: MapType.normal,
          ),
          PopupMenuItem(
            child: Text("hybrid"),
            value: MapType.hybrid,
          ),
          PopupMenuItem(
            child: Text("satellite"),
            value:  MapType.satellite,
          ),
          PopupMenuItem(
            child: Text("terrain"),
            value:  MapType.terrain,
          ),
          PopupMenuItem(
            child: Text("values"),
            value: '/values',
          ),

        ];
      },
    );
  }
}
