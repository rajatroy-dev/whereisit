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

class EditItemTagsInitial extends EditItemEvent {}

class EditItemTagSearch extends EditItemEvent {
  final String tag;

  EditItemTagSearch(this.tag);
}

class EditItemToggleTag extends EditItemEvent {
  final ListItem tag;

  EditItemToggleTag(this.tag);
}

class EditItemUpdateTagCount extends EditItemEvent {
  final int count;

  EditItemUpdateTagCount(this.count);
}

class EditItemTagsSelected extends EditItemEvent {
  final ListItem? tag;

  EditItemTagsSelected({this.tag});
}
