import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_items_event.dart';
part 'search_items_state.dart';

class SearchItemsBloc extends Bloc<SearchItemsEvent, SearchItemsState> {
  SearchItemsBloc() : super(SearchItemsInitial()) {
    on<SearchItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
