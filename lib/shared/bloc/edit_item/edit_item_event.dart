part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemEvent {}

class EditItemFavoriteLabel extends EditItemEvent {
  static const name = 'EditItemFavoriteLabel';
  final CardData itemData;

  EditItemFavoriteLabel(this.itemData);
}

class EditItemLoadExisting extends EditItemEvent {
  static const name = 'EditItemLoadExisting';
  final int id;

  EditItemLoadExisting(this.id);
}

class EditItemExisting extends EditItemEvent {
  static const name = 'EditItemExisting';
  final int id;

  EditItemExisting(this.id);
}

class EditItemNewFirstImage extends EditItemEvent {
  static const name = 'EditItemNewFirstImage';
  final String image;

  EditItemNewFirstImage(this.image);
}

class EditItemNewAdd extends EditItemEvent {
  static const name = 'EditItemNewAdd';
  final CardData itemData;

  EditItemNewAdd(this.itemData);
}

class EditItemTagInitial extends EditItemEvent {
  static const name = 'EditItemTagInitial';
}

class EditItemTagSearch extends EditItemEvent {
  static const name = 'EditItemTagSearch';
  final String tag;

  EditItemTagSearch(this.tag);
}

class EditItemTagAdd extends EditItemEvent {
  static const name = 'EditItemTagAdd';
  final Tag? tag;

  EditItemTagAdd(this.tag);
}

class EditItemTagToggle extends EditItemEvent {
  static const name = 'EditItemTagToggle';
  final Tag tag;

  EditItemTagToggle(this.tag);
}

class EditItemTagRemove extends EditItemEvent {
  final String item;

  EditItemTagRemove(this.item);
}

class EditItemTagDelete extends EditItemEvent {
  static const name = 'EditItemTagDelete';
  final Tag tag;

  EditItemTagDelete(this.tag);
}

class EditItemTagSelectIgnore extends EditItemEvent {
  static const name = 'EditItemTagSelectIgnore';
  EditItemTagSelectIgnore();
}

class EditItemTagUpdateCount extends EditItemEvent {
  static const name = 'EditItemTagUpdateCount';
  final int count;

  EditItemTagUpdateCount(this.count);
}

class EditItemTagsSelected extends EditItemEvent {
  final Tag? tag;

  EditItemTagsSelected({this.tag});
}

class EditItemSubmit extends EditItemEvent {
  final Map<String, String> textInput;

  EditItemSubmit(this.textInput);
}

class EditItemImageAdd extends EditItemEvent {
  static const name = 'EditItemImageAdd';
  final String imagePath;

  EditItemImageAdd(this.imagePath);
}

class EditItemImageRemove extends EditItemEvent {
  static const name = 'EditItemImageRemove';
  final String imagePath;

  EditItemImageRemove(this.imagePath);
}

class EditItemCategoryNew extends EditItemEvent {
  static const name = 'EditItemCategoryNew';
}

class EditItemCategoryLoad extends EditItemEvent {
  static const name = 'EditItemCategoryLoad';
}

class EditItemCategoryAdd extends EditItemEvent {
  final String category;

  EditItemCategoryAdd(this.category);
}

class EditItemSubcategoryAdd extends EditItemEvent {
  static const name = 'EditItemSubcategoryAdd';
  final Map<String, List<String>> subCategory;

  EditItemSubcategoryAdd(this.subCategory);
}

class EditItemCategoryEditIgnore extends EditItemEvent {}

class EditItemCategorySelect extends EditItemEvent {
  static const name = 'EditItemCategorySelect';
  final String category;

  EditItemCategorySelect(this.category);
}

class EditItemSubcategorySelect extends EditItemEvent {
  static const name = 'EditItemSubcategorySelect';
  final Map<String, String> categorySubcategory;

  EditItemSubcategorySelect(this.categorySubcategory);
}

class EditItemCategoryUpdateInitial extends EditItemEvent {
  static const name = 'EditItemCategoryUpdateInitial';
  final String? category;

  EditItemCategoryUpdateInitial({this.category});
}

class EditItemCategoryChange extends EditItemEvent {
  final Map<String, String> newCategory;

  EditItemCategoryChange(this.newCategory);
}

class EditItemSubcategoryChange extends EditItemEvent {
  final Map<String, String> newSubcategory;

  EditItemSubcategoryChange(this.newSubcategory);
}

class EditItemCategoryUpdate extends EditItemEvent {
  static const name = 'EditItemCategoryUpdate';
}

class EditItemSubcategoryUpdate extends EditItemEvent {
  final String subCategory;

  EditItemSubcategoryUpdate(this.subCategory);
}

class EditItemLocationLoad extends EditItemEvent {}

class EditItemLocationSelectIgnore extends EditItemEvent {
  static const name = 'EditItemLocationSelectIgnore';
}

class EditItemLocationSelected extends EditItemEvent {
  static const name = 'EditItemLocationSelected';
  final LatLng location;

  EditItemLocationSelected(this.location);
}

class EditItemAddressLoad extends EditItemEvent {
  static const name = 'EditItemAddressLoad';
}

class EditItemAddressSearch extends EditItemEvent {
  static const name = 'EditItemAddressSearch';
  final String searchString;

  EditItemAddressSearch(this.searchString);
}

class EditItemAddressSelect extends EditItemEvent {
  static const name = 'EditItemAddressSelect';
  final String address;

  EditItemAddressSelect(this.address);
}

class EditItemAddressSelectIgnore extends EditItemEvent {
  static const name = 'EditItemAddressSelectIgnore';
}

class EditItemPropertyLoad extends EditItemEvent {
  static const name = 'EditItemPropertyLoad';
}

class EditItemPropertySearch extends EditItemEvent {
  static const name = 'EditItemPropertySearch';
  final String searchString;

  EditItemPropertySearch(this.searchString);
}

class EditItemPropertySelect extends EditItemEvent {
  static const name = 'EditItemPropertySelect';
  final String property;

  EditItemPropertySelect(this.property);
}

class EditItemPropertySelectIgnore extends EditItemEvent {
  static const name = 'EditItemPropertySelectIgnore';
}
