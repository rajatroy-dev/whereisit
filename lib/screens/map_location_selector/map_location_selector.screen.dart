import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/models/locations.model.dart' as locations;

class MapLocationSelector extends StatefulWidget {
  static const routeName = '/location-map';
  const MapLocationSelector({Key? key}) : super(key: key);

  @override
  State<MapLocationSelector> createState() => _MapLocationSelectorState();
}

class _MapLocationSelectorState extends State<MapLocationSelector> {
  late GoogleMapController mapController;

  List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(-95.67127985317049, 37.05311669685229),
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: AppBarAction.goToSearch,
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
              onCameraMove: _oncameraMove,
            );
          }
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 12,
            ),
            markers: Set<Marker>.of(_markers),
            onCameraMove: _oncameraMove,
          );
        },
      ),
    );
  }
}
