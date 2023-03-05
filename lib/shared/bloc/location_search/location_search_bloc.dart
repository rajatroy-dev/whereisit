import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/shared/validators/input_validator.dart';

part 'location_search_event.dart';
part 'location_search_state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  LocationSearchBloc() : super(LocationSearchInitial()) {
    on<LocationSearchByKeyword>((event, emit) {
      if (InputValidator.address(event.location) != null) {
        emit(LocationSearchFailure('Invalid Input!'));
      } else {
        // TODO: Implement logic
      }
    });
  }
}
