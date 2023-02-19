part of 'update_item_bloc.dart';

@immutable
abstract class UpdateItemState {}

class UpdateItemInitial extends UpdateItemState {}

class UpdateItemFavoriteSuccess extends UpdateItemState {
  final CardData itemData;

  UpdateItemFavoriteSuccess(this.itemData);
}

class UpdateItemAllSuccess extends UpdateItemState {
  final CardData itemData;

  UpdateItemAllSuccess(this.itemData);
}

class UpdateItemNewSuccess extends UpdateItemState {
  final CardData itemData;

  UpdateItemNewSuccess(this.itemData);
}

class UpdateItemFailure extends UpdateItemState {
  final String errorMsg;

  UpdateItemFailure(this.errorMsg);
}
