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
  static const latitude = -95.67127985317049;
  static const longitude = 37.05311669685229;

  var showMyLocationButton = false;
  var currentLocationFound = false;
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
            Permission.location.status.then((status) {
              if (status != PermissionStatus.granted) {
                [Permission.location].request().then((statuses) {
                  if (statuses[Permission.location] ==
                      PermissionStatus.granted) {
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
        });
      } else {
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
        currentLocationFound = true;
      });
    } on Exception {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: AppBarAction.goToSearch,
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
      body: BlocBuilder<LocationSearchBloc, LocationSearchState>(
        builder: (context, state) {
          if (state is LocationSelectionSuccess) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(latitude, longitude),
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
              target: LatLng(latitude, longitude),
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
