part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemState {}

class EditItemInitial extends EditItemState {}

class AddItemInitial extends EditItemState {
  final Item item;

  AddItemInitial(this.item);
}

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

class EditItemTagToggleSuccess extends EditItemState {
  final List<Tag> tags;

  EditItemTagToggleSuccess(this.tags);
}

class EditItemTagSearchSuccess extends EditItemState {
  final List<Tag> tags;

  EditItemTagSearchSuccess(this.tags);
}

class EditItemTagsOnSelectionCountUpdateSuccess extends EditItemState {
  final int selectedTagCount;

  EditItemTagsOnSelectionCountUpdateSuccess(this.selectedTagCount);
}

class EditItemFailure extends EditItemState {
  final String errorMsg;

  EditItemFailure(this.errorMsg);
}

class EditItemTagsSelectionSuccess extends EditItemState {
  final Item item;

  EditItemTagsSelectionSuccess(this.item);
}

class EditItemSubmitSuccess extends EditItemState {
  final Item item;

  EditItemSubmitSuccess(this.item);
}

class EditItemImageAddSuccess extends EditItemState {
  final Item item;

  EditItemImageAddSuccess(this.item);
}

class EditItemImageRemoveSuccess extends EditItemState {
  final Item item;

  EditItemImageRemoveSuccess(this.item);
}

class EditItemCategoryAddSuccess extends EditItemState {
  final Item item;

  EditItemCategoryAddSuccess(this.item);
}

class EditItemCategoryLoadSuccess extends EditItemState {
  final Item item;

  EditItemCategoryLoadSuccess(this.item);
}

class EditItemSubcategoryAddSuccess extends EditItemState {
  final Item item;

  EditItemSubcategoryAddSuccess(this.item);
}

class EditItemCategorySelectSuccess extends EditItemState {
  final Item item;

  EditItemCategorySelectSuccess(this.item);
}

class EditItemCategoryUpdateInitialSuccess extends EditItemState {
  final Item item;

  EditItemCategoryUpdateInitialSuccess(this.item);
}

class EditItemCategoryChangeSuccess extends EditItemState {}

class EditItemSubcategoryChangeSuccess extends EditItemState {}

class EditItemCategoryUpdateSuccess extends EditItemState {}

class EditItemSubcategoryUpdateSuccess extends EditItemState {}
