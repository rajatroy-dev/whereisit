part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemState {}

class EditItemInitial extends EditItemState {}

class EditItemFavoriteSuccess extends EditItemState {
  final CardData itemData;

  EditItemFavoriteSuccess(this.itemData);
}

class EditItemAllSuccess extends EditItemState {
  final CardData itemData;

  EditItemAllSuccess(this.itemData);
}

class EditItemNewSuccess extends EditItemState {
  final CardData itemData;

  EditItemNewSuccess(this.itemData);
}

class EditItemToggleTagSuccess extends EditItemState {
  final List<ListItem> tags;

  EditItemToggleTagSuccess(this.tags);
}

class EditItemFailure extends EditItemState {
  final String errorMsg;

  EditItemFailure(this.errorMsg);
}
