import 'package:google_maps_flutter/google_maps_flutter.dart';

class Point {
  final String uniqueId;
  final LatLng coordinates;

  final String audioLocation;

  Point(this.uniqueId, this.coordinates, this.audioLocation);
}
