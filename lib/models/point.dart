import 'package:google_maps_flutter/google_maps_flutter.dart';

class Point {
  final String uniqueId;
  final LatLng coordinates;

  final String audioLocation;

  Point(this.uniqueId, this.coordinates, this.audioLocation);
}

List<Point> mockPoints = [
  Point("Aya Sofya", LatLng(41.008499492417, 28.98003191818515),
      "audio_recordings/aya_sofya/SoundHelix-Song-2.mp3"),
  Point("Aya Sofya Degil", LatLng(41.008499492417, 28.98103191818515),
      "audio_recordings/aya_sofya/SoundHelix-Song-3.mp3"),
];
