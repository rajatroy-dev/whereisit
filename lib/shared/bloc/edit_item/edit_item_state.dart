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
  const EditItemFavoriteLabelSuccess(Item item) : super(item);
}

class EditItemLoadExistingSuccess extends EditItemState {
  const EditItemLoadExistingSuccess(Item item) : super(item);
}

class EditItemExistingSuccess extends EditItemState {
  const EditItemExistingSuccess(Item item) : super(item);
}

class EditItemNewAddSuccess extends EditItemState {
  const EditItemNewAddSuccess(Item item) : super(item);
}

class EditItemTagToggleSuccess extends EditItemState {
  const EditItemTagToggleSuccess(Item item) : super(item);
}

class EditItemTagSearchSuccess extends EditItemState {
  const EditItemTagSearchSuccess(Item item) : super(item);
}

class EditItemTagsOnSelectionCountUpdateSuccess extends EditItemState {
  const EditItemTagsOnSelectionCountUpdateSuccess(Item item) : super(item);
}

class EditItemFailure extends EditItemState {
  const EditItemFailure(Item item) : super(item);
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
  const EditItemCategoryNewSuccess(Item item) : super(item);
}

class EditItemCategoryAddSuccess extends EditItemState {
  const EditItemCategoryAddSuccess(Item item) : super(item);
}

class EditItemCategoryLoadSuccess extends EditItemState {
  const EditItemCategoryLoadSuccess(Item item) : super(item);
}

class EditItemSubcategoryAddSuccess extends EditItemState {
  const EditItemSubcategoryAddSuccess(Item item) : super(item);
}

class EditItemCategorySelectSuccess extends EditItemState {
  const EditItemCategorySelectSuccess(Item item) : super(item);
}

class EditItemCategoryUpdateInitialSuccess extends EditItemState {
  const EditItemCategoryUpdateInitialSuccess(Item item) : super(item);
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

class EditItemLocationLoadSuccess extends EditItemState {
  // LocationLoadSuccess(this.coordinates);
  const EditItemLocationLoadSuccess(Item item) : super(item);
}

class EditItemLocationSelectIgnoreSuccess extends EditItemState {
  // LocationSearchIgnoreSuccess(this.location);
  const EditItemLocationSelectIgnoreSuccess(Item item) : super(item);
}

class EditItemLocationSelectSuccess extends EditItemState {
  // EditItemLocationSelectSuccess(this.coordinates);
  const EditItemLocationSelectSuccess(Item item) : super(item);
}

class EditItemAddressSearchSuccess extends EditItemState {
  const EditItemAddressSearchSuccess(Item item) : super(item);
}
