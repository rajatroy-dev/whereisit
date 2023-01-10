import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _location;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition cameraPosition) {
    setState(() {
      _cameraPosition = cameraPosition;
    });
  }

  void _onCameraIdle() {
    setState(() {
      _location = LatLng(
        _cameraPosition.target.latitude,
        _cameraPosition.target.longitude,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          onCameraMove: _onCameraMove,
          onCameraIdle: _onCameraIdle,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        const Center(
          //picker image on google map
          child: Icon(Icons.location_on_rounded),
        ),
      ],
    );
  }
}
