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

class EditItemTagToggle extends EditItemEvent {
  final Tag tag;

  EditItemTagToggle(this.tag);
}

class EditItemTagRemove extends EditItemEvent {
  final String item;

  EditItemTagRemove(this.item);
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
