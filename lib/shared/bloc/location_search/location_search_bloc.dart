import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/shared/validators/input_validator.dart';

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

  var selectedAddress = '';
  var selectedLocation = '';

  LocationSearchBloc() : super(LocationSearchInitial()) {
    on<LocationSearchByKeyword>((event, emit) {
      if (InputValidator.address(event.location) != null) {
        emit(LocationSearchFailure('Invalid Input!'));
      } else {
        var temp = locationList
            .where(
              (element) => element.contains(event.location),
            )
            .toList();
        emit(LocationSearchSuccess(temp));
      }
    });

    on<LocationSearchClear>((event, emit) {
      var temp = <String>[];
      emit(LocationSearchSuccess(temp));
    });

    on<LocationSelected>((event, emit) {
      // format: address=alsdalksd&coordinates=12.12,123.123
      var locationDetails = event.location.split('&');

      var temp = <String, String>{};
      var firstKey = locationDetails[0].split('=');
      temp[firstKey[0]] = firstKey[1];
      var secondKey = locationDetails[1].split('=');
      temp[secondKey[0]] = secondKey[1];

      selectedAddress = temp['address']!;
      selectedLocation = temp['coordinates']!;

      emit(LocationSelectionSuccess(temp));
    });
  }
}
