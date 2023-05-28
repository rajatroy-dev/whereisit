part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemState {
  final Item item;

  const EditItemState(this.item);
}

class EditItemInitial extends EditItemState {
  const EditItemInitial(Item item) : super(item);
}

class EditItemNewInitial extends EditItemState {
  const EditItemNewInitial(Item item) : super(item);
}

class EditItemFavoriteLabelSuccess extends EditItemState {
  final CardData cardData;

  const EditItemFavoriteLabelSuccess(Item item, this.cardData) : super(item);
}

class EditItemExistingSuccess extends EditItemState {
  final CardData cardData;

  const EditItemExistingSuccess(Item item, this.cardData) : super(item);
}

class EditItemNewAddSuccess extends EditItemState {
  final CardData cardData;

  const EditItemNewAddSuccess(Item item, this.cardData) : super(item);
}

class EditItemTagToggleSuccess extends EditItemState {
  final List<Tag> tags;

  const EditItemTagToggleSuccess(Item item, this.tags) : super(item);
}

class EditItemTagSearchSuccess extends EditItemState {
  final List<Tag> tags;

  const EditItemTagSearchSuccess(Item item, this.tags) : super(item);
}

class EditItemTagsOnSelectionCountUpdateSuccess extends EditItemState {
  final int selectedTagCount;

  const EditItemTagsOnSelectionCountUpdateSuccess(
      Item item, this.selectedTagCount)
      : super(item);
}

class EditItemFailure extends EditItemState {
  final String errorMsg;

  const EditItemFailure(Item item, this.errorMsg) : super(item);
}

class EditItemTagsSelectionSuccess extends EditItemState {
  const EditItemTagsSelectionSuccess(Item item) : super(item);
}

class EditItemSubmitSuccess extends EditItemState {
  const EditItemSubmitSuccess(Item item) : super(item);
}

class EditItemImageAddSuccess extends EditItemState {
  const EditItemImageAddSuccess(Item item) : super(item);
}

class EditItemImageRemoveSuccess extends EditItemState {
  const EditItemImageRemoveSuccess(Item item) : super(item);
}

class EditItemCategoryNewSuccess extends EditItemState {
  final CatSubcat catSubcat;

  const EditItemCategoryNewSuccess(Item item, this.catSubcat) : super(item);
}

class EditItemCategoryAddSuccess extends EditItemState {
  const EditItemCategoryAddSuccess(Item item) : super(item);
}

class EditItemCategoryLoadSuccess extends EditItemState {
  final CatSubcat catSubcat;

  const EditItemCategoryLoadSuccess(Item item, this.catSubcat) : super(item);
}

class EditItemSubcategoryAddSuccess extends EditItemState {
  const EditItemSubcategoryAddSuccess(Item item) : super(item);
}

class EditItemCategorySelectSuccess extends EditItemState {
  const EditItemCategorySelectSuccess(Item item) : super(item);
}

class EditItemCategoryUpdateInitialSuccess extends EditItemState {
  final CatSubcat catSubcat;

  const EditItemCategoryUpdateInitialSuccess(Item item, this.catSubcat)
      : super(item);
}

class EditItemCategoryChangeSuccess extends EditItemState {
  const EditItemCategoryChangeSuccess(Item item) : super(item);
}

class EditItemSubcategoryChangeSuccess extends EditItemState {
  const EditItemSubcategoryChangeSuccess(Item item) : super(item);
}

class EditItemCategoryUpdateSuccess extends EditItemState {
  const EditItemCategoryUpdateSuccess(Item item) : super(item);
}

class EditItemSubcategoryUpdateSuccess extends EditItemState {
  const EditItemSubcategoryUpdateSuccess(Item item) : super(item);
}
