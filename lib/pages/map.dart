import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
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
      ),
    );
  }
}
