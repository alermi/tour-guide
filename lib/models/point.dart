import 'package:google_maps_flutter/google_maps_flutter.dart';

class Point {
  final String uniqueId;
  final LatLng coordinates;

  final String soundUrl;

  Point(this.uniqueId, this.coordinates, this.soundUrl);
}

List<Point> mockPoints = [
  Point("Aya Sofya", LatLng(41.008499492417, 28.98003191818515),
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"),
  Point("Aya Sofya Degil", LatLng(41.008499492417, 28.98103191818515),
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"),
];
