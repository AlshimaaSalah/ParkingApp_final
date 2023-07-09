import 'dart:math' show cos, sqrt, asin;

import 'package:google_maps_flutter/google_maps_flutter.dart';

double calculateDistance(lat2, lng2) {
  const mainLatLng =
      LatLng(30.051118083560266, 31.328705213963982); // Main Parking lat lng
  final lat1 = mainLatLng.latitude;
  final lng1 = mainLatLng.longitude;
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
