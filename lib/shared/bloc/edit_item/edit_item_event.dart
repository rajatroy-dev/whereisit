part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemEvent {}

class EditItemFavoriteLabel extends EditItemEvent {
  final CardData itemData;

  EditItemFavoriteLabel(this.itemData);
}

class EditItemExisting extends EditItemEvent {
  final String id;

  EditItemExisting(this.id);
}

class EditItemNewFirstImage extends EditItemEvent {
  final String image;

  EditItemNewFirstImage(this.image);
}

class EditItemNewAdd extends EditItemEvent {
  final CardData itemData;

  EditItemNewAdd(this.itemData);
}

class EditItemTagInitial extends EditItemEvent {}

class EditItemTagSearch extends EditItemEvent {
  final String tag;

  EditItemTagSearch(this.tag);
}

class EditItemTagAdd extends EditItemEvent {
  final Tag tag;

  EditItemTagAdd(this.tag);
}

class EditItemTagToggle extends EditItemEvent {
  final Tag tag;

  EditItemTagToggle(this.tag);
}

class EditItemTagRemove extends EditItemEvent {
  final String item;

  EditItemTagRemove(this.item);
}

class EditItemTagDelete extends EditItemEvent {
  final Tag tag;

  EditItemTagDelete(this.tag);
}

class EditItemTagSelectIgnore extends EditItemEvent {
  EditItemTagSelectIgnore();
}

class EditItemTagUpdateCount extends EditItemEvent {
  final int count;

  EditItemTagUpdateCount(this.count);
}

class EditItemTagsSelected extends EditItemEvent {
  final Tag? tag;

  EditItemTagsSelected({this.tag});
}

class EditItemSubmit extends EditItemEvent {
  final Item item;

  EditItemSubmit(this.item);
}

class EditItemImageAdd extends EditItemEvent {
  final String imagePath;

  EditItemImageAdd(this.imagePath);
}

class EditItemImageRemove extends EditItemEvent {
  final String imagePath;

  EditItemImageRemove(this.imagePath);
}

class EditItemCategoryNew extends EditItemEvent {}

class EditItemCategoryLoad extends EditItemEvent {}

class EditItemCategoryAdd extends EditItemEvent {
  final String category;

  EditItemCategoryAdd(this.category);
}

class EditItemSubcategoryAdd extends EditItemEvent {
  final Map<String, List<String>> subCategory;

  EditItemSubcategoryAdd(this.subCategory);
}

class EditItemCategoryEditIgnore extends EditItemEvent {}

class EditItemCategorySelect extends EditItemEvent {
  final String category;

  EditItemCategorySelect(this.category);
}

class EditItemSubcategorySelect extends EditItemEvent {
  final Map<String, String> categorySubcategory;

  EditItemSubcategorySelect(this.categorySubcategory);
}

class EditItemCategoryUpdateInitial extends EditItemEvent {
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

class EditItemCategoryUpdate extends EditItemEvent {}

class EditItemSubcategoryUpdate extends EditItemEvent {
  final String subCategory;

  EditItemSubcategoryUpdate(this.subCategory);
}
