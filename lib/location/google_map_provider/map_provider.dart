

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier{


MapType type = MapType.hybrid;

 
void mapType(MapType mapType){
  type = mapType;
  notifyListeners();
}
}