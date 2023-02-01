part of 'update_item_bloc.dart';

@immutable
abstract class UpdateItemState {}

class UpdateItemInitial extends UpdateItemState {}

class UpdateItemFavoriteSuccess extends UpdateItemState {
  final CardData itemData;

  UpdateItemFavoriteSuccess(this.itemData);
}

class UpdateItemFailure extends UpdateItemState {
  final String errorMsg;

  UpdateItemFailure(this.errorMsg);
}
