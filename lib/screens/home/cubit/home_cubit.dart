import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/tiles_details.model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchTilesDetails() async {
    var list = [TilesDetails('type', 1)];
    emit(FetchTilesDetailsSuccess(list));
    emit(FetchTilesDetailsFailure('Error'));
  }
}
