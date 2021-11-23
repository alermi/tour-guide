import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_guide/models/pack.dart';
import 'package:tour_guide/models/point.dart';
import 'package:tour_guide/models/tour_guide.dart';
import 'package:tour_guide/models/tour_site.dart';

class DatabaseService {
  // static Future<void> initialize() {
  //   return Future.delayed(Duration(milliseconds: 500), () {
  //     initialized = true;
  //   });
  // }

  // static bool initialized = false;
  static DatabaseService _instance = DatabaseService();

  static Map<String, List<String>> packsPerSite = Map();
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
              TourSite(
                  "2",
                  "Efes",
                  LatLng(37.941049, 27.342821),
                  LatLng(37.950225, 27.356006),
                  LatLng(37.93198929717422, 27.33498013909131)),
            ]);
  }

  Future<List<Pack>> getPurchasedTourSitePacks(String tourSiteUniqueId) {
    // if (!initialized) {
    //   throw Exception("Database not initialized");
    // }
    return Future.delayed(Duration(milliseconds: 100), () async {
      List<String> packsUidList = packsPerSite[tourSiteUniqueId] ?? [];

      return Future.wait(packsUidList.map((packUid) {
        return getPack(packUid);
      }));
    });
  }

  Future<Pack> getPack(String packUid) {
    return Future.delayed(Duration(milliseconds: 200), () {
      switch (packUid) {
        case "1":
          return Pack(
              "1", TourGuide("1", "Abdullah Lermi", 4.9), 5.0, 110, 2, "1");
        case "2":
          return Pack("2", TourGuide("2", "Ani Lermi", null), null, 0, 1, "1");
        // case"3":
        //  pack= Pack("3", "Abdullah Lermi", 5.0, 2),;
        case "4":
          return Pack("4", TourGuide("3", "Sule Lermi", 4.7), 5.0, 312, 2, "2");
        default:
          return Future.error("Get pack took in an invalid packUid");
      }
    });
  }

  Future<List<Pack>> getAvailablePacksToPurchase(String tourSiteUniqueId) {
    return Future.delayed(Duration(milliseconds: 100), () async {
      switch (tourSiteUniqueId) {
        case "1":
          return [
            // Pack("1", TourGuide("1", "Abdullah Lermi", 4.9), 5.0, 110, 2, "1"),
            // Pack("2", TourGuide("2", "Ani Lermi", null), null, 0, 1, "1"),
            await getPack("1"),
            await getPack("2"),
          ];
        case "2":
          return [
            // Pack("3", "Abdullah Lermi", 5.0, 2),
            // Pack("4", TourGuide("3", "Sule Lermi", 4.7), 5.0, 312, 2, "2"),
            await getPack("4"),
          ];
        default:
          return [];
      }
    });
  }

  Future<void> purchasePack(String tourSiteUniqueId, String packUniqueId) {
    return Future.delayed(Duration(milliseconds: 500), () {
      // TODO: Do purchase confirmation

      if (packsPerSite[tourSiteUniqueId] == null) {
        packsPerSite[tourSiteUniqueId] = List.empty(growable: true);
      }
      packsPerSite[tourSiteUniqueId]!.add(packUniqueId);
      print("Purchased pack " + packUniqueId + " for site " + tourSiteUniqueId);
      return;
    });
  }

  Future<List<Point>> getPointsInPurchasedPack(String packUniqueId) {
    print('getPointsInPurchasedPack called for packUniqueId ' + packUniqueId);
    return Future.delayed(Duration(milliseconds: 100), () {
      switch (packUniqueId) {
        case "1":
          return [
            Point("Aya Sofya", LatLng(41.008499492417, 28.98003191818515),
                "audio_recordings/aya_sofya/SoundHelix-Song-2.mp3"),
            Point("Aya Sofya Degil", LatLng(41.008499492417, 28.98103191818515),
                "audio_recordings/aya_sofya/SoundHelix-Song-3.mp3"),
          ];
        case "2":
          return [
            Point("Aya Sofya", LatLng(41.008499492417, 28.98003191818515),
                "audio_recordings/aya_sofya/SoundHelix-Song-2.mp3"),
          ];
        case "4":
          return [
            Point(
                "Ancient Direction Signal",
                LatLng(37.939908658246296, 27.341562906160274),
                "audio_recordings/aya_sofya/SoundHelix-Song-2.mp3"),
            Point(
                "Temple of Hadrian",
                LatLng(37.93892713381737, 27.341949144278452),
                "audio_recordings/aya_sofya/SoundHelix-Song-3.mp3"),
          ];
        default:
          return [];
      }
    });
  }

  Map<String, Map<String, double>> reviewMap = Map();
  Future<double?> getUserReview(String userId, String packId) {
    return Future.delayed(Duration(milliseconds: 200), () {
      return reviewMap[userId]?[packId];
    });
    //TODO
  }

  Future<void> leaveReview(String userId, String packId, double rating) {
    return Future.delayed(Duration(milliseconds: 200), () {
      reviewMap.putIfAbsent(userId, () => Map());
      reviewMap[userId]
          ?.update(packId, (value) => rating, ifAbsent: () => rating);
    });
    //TODO
  }
}
