import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourSite {
  final String uniqueId;
  final String siteName;
  final LatLng initialPosition;
  final LatLng northeastBound;
  final LatLng southwestBound;
  final int initialZoom;
  TourSite(this.uniqueId, this.siteName, this.initialPosition,
      this.northeastBound, this.southwestBound,
      {this.initialZoom = 17});
}
