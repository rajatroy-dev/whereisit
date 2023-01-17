import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/tiles_details.model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchTilesDetails() async {
    var list = [
      TilesDetails('Property', 1),
      TilesDetails('Room', 2),
      TilesDetails('Area', 3),
      TilesDetails('Item', 4),
    ];

    emit(FetchFavoriteItemsLoading());

    if (list.isEmpty) {
      emit(FetchTilesDetailsFailure('Error'));
      return;
    }

    emit(FetchTilesDetailsSuccess(list));
  }
}
