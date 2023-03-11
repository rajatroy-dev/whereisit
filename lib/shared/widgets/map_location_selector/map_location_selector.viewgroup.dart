import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';
import 'package:whereisit/models/locations.model.dart' as locations;

class MapLocationSelector extends StatefulWidget {
  static const routeName = '/location-map';
  const MapLocationSelector({Key? key}) : super(key: key);

  @override
  State<MapLocationSelector> createState() => _MapLocationSelectorState();
}

class _MapLocationSelectorState extends State<MapLocationSelector> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
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
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            );
          }
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 2,
            ),
            markers: _markers.values.toSet(),
          );
        },
      ),
    );
  }
}
