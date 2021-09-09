import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_guide/models/point.dart';
import 'package:tour_guide/models/tour_site.dart';

class DatabaseService {
  // static Future<void> initialize() {
  //   return Future.delayed(Duration(milliseconds: 500), () {
  //     initialized = true;
  //   });
  // }

  // static bool initialized = false;
  static DatabaseService _instance = DatabaseService();

  static DatabaseService get instance {
    return _instance;
  }

  Future<List<TourSite>> getTourSites() {
    // if (!initialized) {
    //   throw Exception("Database not initialized");
    // }
    return Future.delayed(
        Duration(milliseconds: 100),
        () => [
              TourSite("1", "Aya Sofya", LatLng(41.007719, 28.979164),
                  LatLng(41.010407, 28.981304), LatLng(41.004685, 28.976260)),
              TourSite("2", "Efes", LatLng(43.007719, 29.979164),
                  LatLng(43.010407, 29.981304), LatLng(43.004685, 29.976260)),
            ]);
  }

  Future<List<Point>> getTourSitePoints(String tourSiteUniqueId) {
    // if (!initialized) {
    //   throw Exception("Database not initialized");
    // }
    return Future.delayed(Duration(milliseconds: 100), () {
      switch (tourSiteUniqueId) {
        case "1":
          return [
            Point("Aya Sofya", LatLng(41.008499492417, 28.98003191818515),
                "audio_recordings/aya_sofya/SoundHelix-Song-2.mp3"),
            Point("Aya Sofya Degil", LatLng(41.008499492417, 28.98103191818515),
                "audio_recordings/aya_sofya/SoundHelix-Song-3.mp3"),
          ];
        case "2":
          return [];
        default:
          return [];
      }
    });
  }
}