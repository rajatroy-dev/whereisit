import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_manager;
import 'package:permission_handler/permission_handler.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class MapLocationSelector extends StatefulWidget {
  static const routeName = '/location-map';
  const MapLocationSelector({Key? key}) : super(key: key);

  @override
  State<MapLocationSelector> createState() => _MapLocationSelectorState();
}

class _MapLocationSelectorState extends State<MapLocationSelector> {
  late GoogleMapController mapController;

  var showMyLocationButton = false;
  List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(-95.67127985317049, 37.05311669685229),
    ),
  ];

  @override
  void initState() {
    Permission.location.serviceStatus.isDisabled.then((isDisabled) {
      if (isDisabled) {
        var loc = location_manager.Location();
        loc.requestService().then((granted) {
          if (granted) {
            Permission.location.status.then((status) {
              if (status != PermissionStatus.granted) {
                [Permission.location].request();
              }
            });
          }
        });
      }
    });
    super.initState();
  }

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _oncameraMove(CameraPosition pos) async {
    setState(() {
      _markers = <Marker>[
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(pos.target.latitude, pos.target.longitude),
        ),
      ];
    });
  }

  void _currentLocation() async {
    try {
      var location = location_manager.Location();
      location_manager.LocationData currentLocation =
          await location.getLocation();
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(
              currentLocation.latitude!,
              currentLocation.longitude!,
            ),
            zoom: 17.0,
          ),
        ),
      );
      setState(() {
        _markers = <Marker>[
          Marker(
            markerId: const MarkerId('1'),
            position: LatLng(
              currentLocation.latitude!,
              currentLocation.longitude!,
            ),
          ),
        ];
      });
    } on Exception {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: AppBarAction.goToSearch,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple,
        onPressed: _currentLocation,
        child: const Icon(Icons.my_location_outlined),
      ),
      body: BlocBuilder<LocationSearchBloc, LocationSearchState>(
        builder: (context, state) {
          if (state is LocationSelectionSuccess) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 12,
              ),
              markers: Set<Marker>.of(_markers),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onCameraMove: _oncameraMove,
              zoomControlsEnabled: false,
            );
          }
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 12,
            ),
            markers: Set<Marker>.of(_markers),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onCameraMove: _oncameraMove,
            zoomControlsEnabled: false,
          );
        },
      ),
    );
  }
}
