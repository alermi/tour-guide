import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_guide/models/point.dart';
import 'package:tour_guide/pages/audio/audio_page_manager.dart';
import 'package:tour_guide/pages/audio/audio_player.dart';
import 'package:tour_guide/services/storage.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  _MapPageState() {
    //TODO: Probably call this somewhere else
    for (Point point in mockPoints) {
      StorageService.downloadFile(point.soundUrl);
    }
  }

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
    audioPageManager.setUrl(_newPoint.soundUrl);
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> _markers = mockPoints
        .map((e) => Marker(
            markerId: MarkerId(e.uniqueId),
            position: e.coordinates,
            infoWindow: InfoWindow(title: e.uniqueId, snippet: ""),
            onTap: () {
              setCurrentPoint(e);
            }))
        .toList();
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        minMaxZoomPreference: MinMaxZoomPreference(16, 20),
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            northeast: LatLng(41.010407, 28.981304),
            southwest: LatLng(41.004685, 28.976260),
          ),
        ),
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(41.007719, 28.979164),
          zoom: 17.0,
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
}
