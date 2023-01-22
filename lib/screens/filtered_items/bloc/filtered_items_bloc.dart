import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';

part 'filtered_items_event.dart';
part 'filtered_items_state.dart';

class FilteredItemsBloc extends Bloc<FilteredItemsEvent, FilteredItemsState> {
  FilteredItemsBloc() : super(FilteredItemsInitial()) {
    on<FilteredItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
