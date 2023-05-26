import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_manager;
import 'package:permission_handler/permission_handler.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class MapLocationSelector extends StatefulWidget {
  static const routeName = '/location-map';
  const MapLocationSelector({Key? key}) : super(key: key);

  @override
  State<MapLocationSelector> createState() => _MapLocationSelectorState();
}

class _MapLocationSelectorState extends State<MapLocationSelector> {
  late GoogleMapController mapController;
  static const latitude = -95.67127985317049;
  static const longitude = 37.05311669685229;

  var showMyLocationButton = false;
  var currentLocationFound = false;
  var initiatedByMyLocationButton = false;
  late LatLng coordinates;
  List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(latitude, longitude),
    ),
  ];

  @override
  void initState() {
    Permission.location.serviceStatus.isDisabled.then((isDisabled) {
      if (isDisabled) {
        var loc = location_manager.Location();
        loc.requestService().then((granted) {
          if (granted) {
            _handlePermissionRequestAndLocationButtonDisplay();
          }
        });
      } else {
        _handlePermissionRequestAndLocationButtonDisplay();
      }
    });
    super.initState();
  }

  _handlePermissionRequestAndLocationButtonDisplay() {
    Permission.location.status.then((status) {
      if (status != PermissionStatus.granted) {
        [Permission.location].request().then((statuses) {
          if (statuses[Permission.location] == PermissionStatus.granted) {
            setState(() {
              showMyLocationButton = true;
            });
          }
        });
      } else {
        setState(() {
          showMyLocationButton = true;
        });
      }
    });
  }

  _onMapCreated(GoogleMapController controller, LatLng location) {
    mapController = controller;

    if (location.latitude != 0 && location.longitude != 0) {
      setState(() {
        _markers = <Marker>[
          Marker(
            markerId: const MarkerId('1'),
            position: location,
          ),
        ];
      });
    }
  }

  _oncameraMove(CameraPosition pos) async {
    setState(() {
      _markers = <Marker>[
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(pos.target.latitude, pos.target.longitude),
        ),
      ];
      coordinates = LatLng(pos.target.latitude, pos.target.longitude);
      currentLocationFound = false;
    });
  }

  _onCameraIdle() {
    if (initiatedByMyLocationButton) {
      setState(() {
        currentLocationFound = true;
        initiatedByMyLocationButton = false;
      });
    }
  }

  void _getCurrentLocation() async {
    try {
      currentLocationFound = false;
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
        initiatedByMyLocationButton = true;
      });
    } on Exception {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: showMyLocationButton
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.purple,
              onPressed: _getCurrentLocation,
              child: currentLocationFound
                  ? const Icon(Icons.my_location_outlined)
                  : const Icon(Icons.location_searching_rounded),
            )
          : null,
      body: Stack(
        children: [
          BlocBuilder<LocationSearchBloc, LocationSearchState>(
            builder: (context, state) {
              if (state is LocationLoadSuccess) {
                return GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _onMapCreated(controller, state.coordinates);
                  },
                  initialCameraPosition: CameraPosition(
                    target: state.coordinates,
                    zoom: 17,
                  ),
                  markers: Set<Marker>.of(_markers),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onCameraMove: _oncameraMove,
                  onCameraIdle: _onCameraIdle,
                  zoomControlsEnabled: false,
                );
              }
              return GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _onMapCreated(controller, const LatLng(0, 0));
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 12,
                ),
                markers: Set<Marker>.of(_markers),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onCameraMove: _oncameraMove,
                onCameraIdle: _onCameraIdle,
                zoomControlsEnabled: false,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LocationSearchBloc>(context).add(
                    LocationSelected(coordinates),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Select this location'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
