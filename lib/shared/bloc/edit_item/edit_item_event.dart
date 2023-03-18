part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemEvent {}

class EditItemFavorite extends EditItemEvent {
  final CardData itemData;

  EditItemFavorite(this.itemData);
}

class EditItemAll extends EditItemEvent {
  final String id;

  EditItemAll(this.id);
}

class EditItemNew extends EditItemEvent {
  final CardData itemData;

  EditItemNew(this.itemData);
}

class EditItemTagsInitial extends EditItemEvent {}

class EditItemToggleTag extends EditItemEvent {
  final ListItem tag;

  EditItemToggleTag(this.tag);
}
