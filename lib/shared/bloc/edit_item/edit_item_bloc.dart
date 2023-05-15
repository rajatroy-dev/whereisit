import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/models/cat_subcat.model.dart';
import 'package:whereisit/models/item.model.dart';
import 'package:whereisit/models/tag.model.dart';

part 'edit_item_event.dart';
part 'edit_item_state.dart';

class EditItemBloc extends Bloc<EditItemEvent, EditItemState> {
  var list = <CardData>[
    CardData(
      id: "1",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 1",
      location: "A random location 1",
      qty: 5,
      tags: ["tag1", "tag2"],
      createdAt: "2022-12-03",
      isFavorite: true,
    ),
    CardData(
      id: "2",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 2",
      location: "A random location 2",
      qty: 6,
      tags: ["tag3", "tag4"],
      createdAt: "2022-11-13",
    ),
    CardData(
      id: "3",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 3",
      location: "A random location 3",
      qty: 7,
      tags: ["tag5", "tag6"],
      createdAt: "2022-10-11",
      isFavorite: true,
    ),
    CardData(
      id: "4",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 4",
      location: "A random location 4",
      qty: 8,
      tags: ["tag1", "tag6"],
      createdAt: "2022-09-05",
    ),
    CardData(
      id: "5",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 5",
      location: "A random location 5",
      qty: 9,
      tags: ["tag2", "tag5"],
      createdAt: "2022-08-15",
      isFavorite: false,
    ),
    CardData(
      id: "6",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 6",
      location: "A random location 6",
      qty: 1,
      tags: ["tag3", "tag4"],
      createdAt: "2022-07-12",
    ),
    CardData(
      id: "7",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 7",
      location: "A random location 7",
      qty: 2,
      tags: ["tag7", "tag8"],
      createdAt: "2022-06-06",
    ),
    CardData(
      id: "8",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 8",
      location: "A random location 8",
      qty: 3,
      tags: ["tag9", "tag10"],
      createdAt: "2022-05-19",
    ),
    CardData(
      id: "9",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 9",
      location: "A random location 9",
      qty: 4,
      tags: ["tag7", "tag10"],
      createdAt: "2022-04-17",
      isFavorite: true,
    ),
    CardData(
      id: "10",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 10",
      location: "A random location 10",
      qty: 10,
      tags: ["tag8", "tag9"],
      createdAt: "2022-03-20",
    ),
  ];

  var imageList = <String>[];

  var newItem = CardData.empty();

  var item = Item.forUi({
    'uiTagsList': [],
    'uiImagesList': [],
    'uiSelectedCategory': '',
  });

  var tags = <Tag>[
    Tag(isSelected: false, isNew: false, item: 'Alaskan Malamute'),
    Tag(isSelected: false, isNew: false, item: 'Bohemian Shepherd'),
    Tag(isSelected: false, isNew: false, item: 'Cane Corso'),
    Tag(isSelected: false, isNew: false, item: 'Dobermann'),
    Tag(isSelected: false, isNew: false, item: 'English Mastiff'),
    Tag(isSelected: false, isNew: false, item: 'Finnish Hound'),
    Tag(isSelected: false, isNew: false, item: 'Great Dane'),
  ];
  var editedTags = <Tag>[];
  var tagsToHandleBackNavigation = <Tag>[];

  var selectedTagCount = 0;

  var categories = <String>['Clothes', 'Books', 'Miscellanous'];
  Map<String, List<String>> subCategories = {
    'Clothes': ['Jeans', 'Shirts', 'T-Shirts'],
    'Books': ['Science Fiction', 'Adventure', 'Romantic'],
    'Miscellanous': [],
  };

  var editedCategory = <String, String>{};
  var editedSubcategory = <String, List<String>>{};

  var selectedCategorySubCategory = '';
  var stringtoHandleCategoryBack = '';

  _toggleTagSelection(dynamic event) {
    if (event is EditItemTagToggle) {
      for (var element in editedTags) {
        if (element.item == event.tag.item) {
          element = Tag(
            isNew: event.tag.isNew,
            item: event.tag.item,
            isSelected: event.tag.isSelected!,
            value: event.tag.value,
          );
        }
      }
    }
  }

  EditItemBloc() : super(EditItemInitial()) {
    on<EditItemLoadNew>((event, emit) {
      emit(EditItemInitial());
    });

    on<EditItemFavorite>((event, emit) {
      var item = event.itemData;

      for (var element in list) {
        if (element.id == item.id) {
          element.isFavorite = item.isFavorite;
        }
      }

      emit(EditItemFavoriteSuccess(item));
    });

    on<EditItemAll>((event, emit) {
      var item = list.firstWhere(
        (element) => element.id == event.id,
      );

      for (var element in list) {
        if (element.id == item.id) {
          element = CardData(
            id: item.id,
            title: item.title,
            imageSrc: item.imageSrc,
            location: item.location,
            qty: item.qty,
            tags: item.tags,
            createdAt: item.createdAt,
            isFavorite: item.isFavorite == null ? false : item.isFavorite!,
          );
        }
      }

      emit(EditItemFavoriteSuccess(item));
    });

    on<EditItemNew>((event, emit) {
      var item = CardData(
        id: event.itemData.id,
        title: event.itemData.title,
        imageSrc: event.itemData.imageSrc,
        location: event.itemData.location,
        qty: event.itemData.qty,
        tags: event.itemData.tags,
        createdAt: event.itemData.createdAt,
        isFavorite: false,
      );

      list.add(item);

      emit(EditItemNewSuccess(item));
    });

    on<AddItemFirstImage>(
      (event, emit) {
        item = Item.forUi({
          'thumbnail': event.image,
          'uiTagsList': [],
          'uiImagesList': [event.image],
          'uiSelectedCategory': '',
        });

        emit(AddItemInitial(item));
      },
    );

    on<EditItemTagInitial>(
      // What are the cases?
      // We have an original list of tags.
      // This list will be displayed on first load.
      // From second list onwards, the edited list of tags.
      // So, now we have twlist of tags.
      // Do, we need a third list that will contain only the selected list of tags?
      // My answer is no.
      // But we might need a third list, for when back button is pressed.
      (event, emit) {
        if (editedTags.isEmpty) {
          for (var element in tags) {
            editedTags.add(
              Tag(
                isNew: element.isNew,
                item: element.item,
                isSelected: element.isSelected,
                value: element.value,
              ),
            );
            tagsToHandleBackNavigation.add(
              Tag(
                isNew: element.isNew,
                item: element.item,
                isSelected: element.isSelected,
                value: element.value,
              ),
            );
          }
        }
        emit(EditItemTagToggleSuccess(editedTags));
      },
    );

    on<EditItemTagSearch>(
      (event, emit) {
        var exists = false;
        var temp = <Tag>[];

        for (var element in editedTags) {
          var elementItemInLowerCase = element.item.toLowerCase();
          var eventItemInLowerCase = event.tag.toLowerCase();
          if (elementItemInLowerCase.contains(eventItemInLowerCase)) {
            exists = true;
            temp.add(element);
          }
        }

        if (!exists) {
          temp = [
            Tag(
              isNew: true,
              item: '+ Add "${event.tag}" to list',
              isSelected: false,
              value: event.tag,
            ),
            ...temp,
          ];
        }

        emit(EditItemTagSearchSuccess(temp));
      },
    );

    on<EditItemTagToggle>(
      (event, emit) {
        _toggleTagSelection(event);
        emit(EditItemTagToggleSuccess(editedTags));
      },
    );

    on<EditItemTagAdd>(
      (event, emit) {
        // Add to tags list
        // Add to edited tags list. The item should be in selected state.
        // Update tag count
        // Clear search
        // Handle tag remove after add

        tags.add(
          Tag(
            isSelected: false,
            isNew: false,
            item: event.tag.value!,
          ),
        );
        var selected = Tag(
          isSelected: true,
          isNew: false,
          item: event.tag.value!,
        );
        editedTags.add(selected);
        selectedTagCount++;
        emit(EditItemTagToggleSuccess([selected]));
      },
    );

    on<EditItemTagUpdateCount>(
      (event, emit) {
        event.count > 0 ? selectedTagCount++ : selectedTagCount--;
        emit(EditItemTagsOnSelectionCountUpdateSuccess(selectedTagCount));
      },
    );

    on<EditItemTagsSelected>(
      (event, emit) {
        item.uiTagsList = <Tag>[];
        tagsToHandleBackNavigation = <Tag>[];
        for (var element in editedTags) {
          tagsToHandleBackNavigation.add(
            Tag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
          item.uiTagsList!.add(
            Tag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
        }
        emit(EditItemTagsSelectionSuccess(item));
      },
    );

    on<EditItemTagSelectIgnore>(
      (event, emit) {
        editedTags = <Tag>[];
        selectedTagCount = 0;
        for (var element in tagsToHandleBackNavigation) {
          if (element.isSelected != null && element.isSelected!) {
            selectedTagCount++;
          }
          editedTags.add(
            Tag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
        }
        emit(EditItemTagsSelectionSuccess(item));
      },
    );

    on<EditItemTagRemove>(
      (event, emit) {
        int index = 0;
        for (var i = 0; i < editedTags.length; i++) {
          if (editedTags[i].item == event.item) {
            index = i;
            break;
          }
        }
        editedTags[index] = Tag(
          isNew: editedTags[index].isNew,
          item: editedTags[index].item,
          isSelected: false,
          value: editedTags[index].value,
        );
        item.uiTagsList = <Tag>[];
        tagsToHandleBackNavigation = <Tag>[];
        for (var element in editedTags) {
          tagsToHandleBackNavigation.add(
            Tag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
          item.uiTagsList!.add(
            Tag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
        }
        selectedTagCount--;
        emit(EditItemTagsSelectionSuccess(item));
      },
    );

    on<EditItemTagDelete>(
      (event, emit) {
        tags.removeWhere((element) => element.item == event.tag.item);
        editedTags.removeWhere((element) => element.item == event.tag.item);
        item.uiTagsList!.removeWhere(
          (element) => element.item == event.tag.item,
        );
        tagsToHandleBackNavigation.removeWhere(
          (element) => element.item == event.tag.item,
        );
        if (event.tag.isSelected != null && event.tag.isSelected!) {
          selectedTagCount--;
        }
        emit(EditItemTagToggleSuccess(editedTags));
      },
    );

    on<EditItemSubmit>(
      (event, emit) {
        item = event.item;
        emit(EditItemSubmitSuccess(item));
      },
    );

    on<EditItemImageAdd>(
      (event, emit) {
        item.uiImagesList!.add(event.imagePath);
        if (item.uiImagesList!.length == 1) {
          item = Item.forUi({
            'thumbnail': event.imagePath,
            'uiTagsList': item.uiTagsList,
            'uiImagesList': item.uiImagesList,
            'uiSelectedCategory': item.uiSelectedCategory,
          });
        }

        emit(EditItemImageAddSuccess(item));
      },
    );

    on<EditItemImageRemove>(
      (event, emit) {
        var temp = [...item.uiImagesList!];
        temp.remove(event.imagePath);
        if (temp.isEmpty) {
          item = Item.forUi({
            'thumbnail': '',
            'uiTagsList': item.uiTagsList,
            'uiImagesList': [],
            'uiSelectedCategory': item.uiSelectedCategory,
          });
        } else {
          item.uiImagesList = temp;
        }

        emit(EditItemImageRemoveSuccess(item));
      },
    );

    on<EditItemCategoryNew>((event, emit) {
      var item = CatSubcat(
        categories: categories,
        subcategories: subCategories,
      );

      emit(EditItemCategoryNewSuccess(item));
    });

    on<EditItemCategoryLoad>(
      (event, emit) {
        stringtoHandleCategoryBack = selectedCategorySubCategory;
        var item = CatSubcat(
          categories: categories,
          subcategories: subCategories,
        );

        emit(EditItemCategoryLoadSuccess(item));
      },
    );

    on<EditItemCategoryEditIgnore>(
      (event, emit) {
        selectedCategorySubCategory = stringtoHandleCategoryBack;
        editedCategory = {};
        editedSubcategory = {};

        emit(EditItemCategoryAddSuccess(item));
      },
    );

    on<EditItemCategorySelect>(
      (event, emit) {
        selectedCategorySubCategory = event.category;

        item = Item.forUi({
          'thumbnail': item.thumbnail,
          'uiTagsList': item.uiTagsList,
          'uiImagesList': item.uiImagesList,
          'uiSelectedCategory': selectedCategorySubCategory,
        });

        emit(EditItemCategorySelectSuccess(item));
      },
    );

    on<EditItemSubcategorySelect>(
      (event, emit) {
        var category = '';
        var subcategory = '';

        for (var element in event.categorySubcategory.entries) {
          category = element.key;
          subcategory = element.value;
          break;
        }

        selectedCategorySubCategory = '$category > $subcategory';

        item = Item.forUi({
          'thumbnail': item.thumbnail,
          'uiTagsList': item.uiTagsList,
          'uiImagesList': item.uiImagesList,
          'uiSelectedCategory': selectedCategorySubCategory,
        });

        emit(EditItemCategorySelectSuccess(item));
      },
    );

    on<EditItemCategoryAdd>(
      (event, emit) {
        categories.add(event.category);

        emit(EditItemCategoryAddSuccess(item));
      },
    );

    on<EditItemSubCategoryAdd>(
      // What are the cases?
      // We have an original list of categories and subCategories.
      // This list will be displayed on first load.
      // From second list onwards, the edited list of categories and subcategories.
      // So, now we have two list of categories and subcategories.
      // But we might need a third list, for when back button is pressed.
      (event, emit) {
        var hasCategory = false;

        hasCategory = categories.any(
          (element) => element == event.subCategory.keys.first,
        );

        if (hasCategory && event.subCategory.length == 1) {
          var key = event.subCategory.keys.first;
          var value = event.subCategory.keys.first;

          if (subCategories.containsKey(key)) {
            subCategories[key]!.add(value);
          } else {
            subCategories[key] = [value];
          }
        }

        emit(EditItemCategoryAddSuccess(item));
      },
    );

    on<EditItemCategoryUpdateInitial>(
      (event, emit) {
        var item = CatSubcat(
          categories: categories,
          subcategories: subCategories,
        );
        emit(EditItemCategoryUpdateInitialSuccess(item));
      },
    );

    on<EditItemCategoryChange>(
      (event, emit) {
        var entry = event.newCategory.entries.first;
        editedCategory[entry.key] = entry.value;
        editedSubcategory[entry.key] = subCategories[entry.key] ?? [];

        emit(EditItemCategoryChangeSuccess());
      },
    );

    on<EditItemSubcategoryChange>(
      (event, emit) {
        var entry = event.newSubcategory.entries.first;
        var afterSplit = entry.key.split(':');
        var index = int.parse(afterSplit[0]);
        var category = afterSplit[1];

        editedSubcategory[category] = [...subCategories[category]!];
        editedSubcategory[category]![index] = entry.value;

        emit(EditItemCategoryChangeSuccess());
      },
    );

    on<EditItemCategoryUpdate>(
      (event, emit) {
        // If there is a category selected, edit it
        var itemExistingCategory = '';
        var toBeUpdatedItemCategory = '';
        var splitItemCategorySubcategory = <String>[];
        if (item.uiSelectedCategory != null &&
            item.uiSelectedCategory!.isNotEmpty) {
          splitItemCategorySubcategory = item.uiSelectedCategory!.split('>');
          itemExistingCategory = splitItemCategorySubcategory[0].trim();
        }

        if (editedCategory.isEmpty && editedSubcategory.isNotEmpty) {
          // handle only sub-category update
          for (var element in editedSubcategory.entries) {
            editedCategory[element.key] = element.key;
          }
        } else {
          for (var element in editedCategory.entries) {
            var index = categories.indexWhere((_item) => _item == element.key);
            categories[index] = element.value;
            if (itemExistingCategory.isNotEmpty &&
                element.key == itemExistingCategory) {
              toBeUpdatedItemCategory = element.value;
            }
          }
        }

        // If there is a subcategory selected, edit it
        var itemExistingSubcategory = '';
        if (splitItemCategorySubcategory.length > 1) {
          itemExistingSubcategory = splitItemCategorySubcategory[1].trim();
        }
        var toBeUpdatedItemSubcategory = '';
        var subCategoryIndex = -1;

        for (var element in editedSubcategory.entries) {
          if (element.value.isNotEmpty) {
            // First get the index of exisiting selected subcategory if present
            if (toBeUpdatedItemCategory.isNotEmpty &&
                subCategoryIndex < 0 &&
                subCategories[itemExistingCategory] != null &&
                subCategories[itemExistingCategory]!.isNotEmpty) {
              subCategoryIndex = subCategories[itemExistingCategory]!
                  .indexWhere((_item) => _item == itemExistingSubcategory);
              // Edit the selectedSubcategory
              toBeUpdatedItemSubcategory =
                  editedSubcategory[itemExistingCategory]![subCategoryIndex];
            }
            // Then remove the key
            subCategories.remove(element.key);
            // Then add the new key with new value
            subCategories[editedCategory[element.key]!] = element.value;
          }
        }

        if (toBeUpdatedItemCategory.isNotEmpty) {
          selectedCategorySubCategory = toBeUpdatedItemCategory;
        }
        if (toBeUpdatedItemSubcategory.isNotEmpty) {
          selectedCategorySubCategory = ' > $toBeUpdatedItemSubcategory';
        }

        editedCategory = {};
        editedSubcategory = {};
        item = Item.forUi({
          'thumbnail': item.thumbnail,
          'uiTagsList': item.uiTagsList,
          'uiImagesList': item.uiImagesList,
          'uiSelectedCategory': selectedCategorySubCategory,
        });

        emit(EditItemCategoryUpdateSuccess(item));
      },
    );

    on<EditItemSubcategoryUpdate>(
      (event, emit) {
        var res = event.subCategory.split(',');
        var index = int.parse(res[0]);
        var category = res[1];
        var subCategory = res[2];

        if (subCategories.containsKey(category)) {
          subCategories[category]![index] = subCategory;

          emit(EditItemSubcategoryUpdateSuccess());
        }
      },
    );
  }
}
