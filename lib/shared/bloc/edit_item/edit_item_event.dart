part of 'edit_item_bloc.dart';

@immutable
abstract class EditItemEvent {}

class EditItemLoadNew extends EditItemEvent {}

class EditItemFavorite extends EditItemEvent {
  final CardData itemData;

  EditItemFavorite(this.itemData);
}

class EditItemAll extends EditItemEvent {
  final String id;

  EditItemAll(this.id);
}

class AddItemFirstImage extends EditItemEvent {
  final String image;

  AddItemFirstImage(this.image);
}

class EditItemNew extends EditItemEvent {
  final CardData itemData;

  EditItemNew(this.itemData);
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

class EditItemCategoryInitial extends EditItemEvent {}

class EditItemCategoryAdd extends EditItemEvent {
  final String category;

  EditItemCategoryAdd(this.category);
}

class EditItemSubCategoryAdd extends EditItemEvent {
  final Map<String, String> subCategory;

  EditItemSubCategoryAdd(this.subCategory);
}

class EditItemCategoryEditIgnore extends EditItemEvent {}

class EditItemCategorySelect extends EditItemEvent {
  final String category;

  EditItemCategorySelect(this.category);
}

class EditItemSubcategorySelect extends EditItemEvent {
  final String subCategory;

  EditItemSubcategorySelect(this.subCategory);
}

class EditItemCategoryUpdate extends EditItemEvent {
  final String category;

  EditItemCategoryUpdate(this.category);
}

class EditItemSubcategoryUpdate extends EditItemEvent {
  final String subCategory;

  EditItemSubcategoryUpdate(this.subCategory);
}
