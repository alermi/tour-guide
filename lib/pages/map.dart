import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_guide/models/point.dart';
import 'package:tour_guide/models/tour_site.dart';
import 'package:tour_guide/pages/audio/audio_page_manager.dart';
import 'package:tour_guide/pages/audio/audio_player.dart';
import 'package:tour_guide/pages/error.dart';
import 'package:tour_guide/pages/get_pack.dart';
import 'package:tour_guide/pages/loading.dart';
import 'package:tour_guide/services/database.dart';
import 'package:tour_guide/services/storage.dart';

class MapPage extends StatefulWidget {
  MapPage(this.tourSite, {Key? key}) : super(key: key);

  final TourSite tourSite;
  @override
  _MapPageState createState() => _MapPageState(tourSite);
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  _MapPageState(this.tourSite)
      : tourSitePointsFuture = DatabaseService.instance
            .getPurchasedTourSitePoints(tourSite.uniqueId) {
    tourSitePointsFuture.then((pointList) {
      setState(() {
        tourSitePoints = pointList;
        var _downloadFutures = pointList
            .map((point) => StorageService.downloadFile(point.audioLocation))
            .toList();
        downloadFuturesWait = Future.wait(_downloadFutures);
      });
    });
  }
  Future<void>? downloadFuturesWait;
  final TourSite tourSite;
  Future<List<Point>> tourSitePointsFuture;
  List<Point>? tourSitePoints;
  Point? _currentPoint;
  late GoogleMapController mapController;
  final AudioPageManager audioPageManager = AudioPageManager();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  setCurrentPoint(Point _newPoint) {
    setState(() {
      _currentPoint = _newPoint;
    });
    audioPageManager.setUrl(_newPoint.audioLocation);
  }

  @override
  Widget build(BuildContext context) {
    if (downloadFuturesWait == null) {
      return MaterialApp(home: LoadingPage());
    }
    return FutureBuilder(
      // Initialize FlutterFire:
      future: downloadFuturesWait,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              home: ErrorPage(message: snapshot.error.toString()));
        }
        // Once complete, show your application
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(home: LoadingPage());
        } else {
          final List<Marker> _markers = tourSitePoints!
              .map((e) => Marker(
                  markerId: MarkerId(e.uniqueId),
                  position: e.coordinates,
                  infoWindow: InfoWindow(title: e.uniqueId, snippet: ""),
                  onTap: () {
                    setCurrentPoint(e);
                  }))
              .toList();
          return Scaffold(
            appBar: AppBar(),
            body: tourSitePoints!.isEmpty
                ? GetPackView(tourSite)
                : GoogleMap(
                    mapType: MapType.hybrid,
                    myLocationEnabled: true,
                    //TODO: Add this as a TourSite data too maybe
                    minMaxZoomPreference: MinMaxZoomPreference(16, 20),
                    cameraTargetBounds: CameraTargetBounds(
                      LatLngBounds(
                          northeast: tourSite.northeastBound,
                          southwest: tourSite.southwestBound),
                    ),
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: tourSite.initialPosition,
                      zoom: tourSite.initialZoom,
                    ),
                    markers: _markers.toSet(),
                  ),
            bottomSheet: _currentPoint != null
                ? Container(
                    height: 130,
                    child: AudioPlayerView(
                      audioPageManager: audioPageManager,
                    ),
                  )
                : null,
          );
        }
      },
    );
  }
}
