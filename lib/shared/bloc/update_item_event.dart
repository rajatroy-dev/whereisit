part of 'update_item_bloc.dart';

@immutable
abstract class UpdateItemEvent {}

class UpdateItemFavorite extends UpdateItemEvent {
  final CardData itemData;

  UpdateItemFavorite(this.itemData);
}

class UpdateItemAll extends UpdateItemEvent {
  final String id;

  UpdateItemAll(this.id);
}
