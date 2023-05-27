part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemState {}

class EditItemInitial extends EditItemState {}

class EditItemNewInitial extends EditItemState {
  final Item item;

  EditItemNewInitial(this.item);
}

class EditItemFavoriteLabelSuccess extends EditItemState {
  final CardData itemData;

  EditItemFavoriteLabelSuccess(this.itemData);
}

class EditItemExistingSuccess extends EditItemState {
  final CardData itemData;

  EditItemExistingSuccess(this.itemData);
}

class EditItemNewAddSuccess extends EditItemState {
  final CardData itemData;

  EditItemNewAddSuccess(this.itemData);
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

class EditItemCategoryNewSuccess extends EditItemState {
  final CatSubcat item;

  EditItemCategoryNewSuccess(this.item);
}

class EditItemCategoryAddSuccess extends EditItemState {
  final Item item;

  EditItemCategoryAddSuccess(this.item);
}

class EditItemCategoryLoadSuccess extends EditItemState {
  final CatSubcat item;

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
  final CatSubcat item;

  EditItemCategoryUpdateInitialSuccess(this.item);
}

class EditItemCategoryChangeSuccess extends EditItemState {}

class EditItemSubcategoryChangeSuccess extends EditItemState {}

class EditItemCategoryUpdateSuccess extends EditItemState {
  final Item item;

  EditItemCategoryUpdateSuccess(this.item);
}

class EditItemSubcategoryUpdateSuccess extends EditItemState {}
