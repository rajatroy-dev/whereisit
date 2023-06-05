import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'location_search_event.dart';
part 'location_search_state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  var locationList = <String>[
    '20349 Balistreri Gardens, Grantshire, New Mexico, 99076',
    '62683 Ivah Islands, Owensboro, Massachusetts, 22007',
    '3800 Dortha Keys, San Marcos, Connecticut, 21362-0781',
    '46455 Goldner Overpass, Port Haskellborough, Idaho, 60367-0554',
    '4787 Hamill Ports, South Kraig, Arkansas, 80011-5156',
    '768 Rose Manors, Casperview, Minnesota, 77347-7288',
    '10169 Walton Vista, Scotview, Virginia, 41113',
    '0439 Noble Fields, New Murphy, Nevada, 42788',
    '8348 Marques Orchard, South Evertburgh, Texas, 95913',
    '70081 Kunze Forges, Amanimouth, Delaware, 88948-3490',
  ];

  LatLng selectedLocation = const LatLng(
    -95.67127985317049,
    37.05311669685229,
  );

  LocationSearchBloc() : super(LocationSearchInitial()) {
    on<LocationLoad>((event, emit) {
      emit(LocationLoadSuccess(selectedLocation));
    });

    on<LocationSelected>((event, emit) {
      var temp = <String, String>{};
      temp['latitude'] = event.location.latitude.toStringAsFixed(2);
      temp['longitude'] = event.location.longitude.toStringAsFixed(2);

      selectedLocation = event.location;

      emit(LocationSelectionSuccess(temp));
    });

    on<LocationSelectIgnore>((event, emit) {
      LatLng temp = LatLng(
        double.parse(selectedLocation.latitude.toStringAsFixed(2)),
        double.parse(selectedLocation.longitude.toStringAsFixed(2)),
      );
      emit(LocationSearchIgnoreSuccess(temp));
    });
  }
}
