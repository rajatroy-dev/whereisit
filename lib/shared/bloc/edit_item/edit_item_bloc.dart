import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/models/cat_subcat.model.dart';
import 'package:whereisit/models/item.model.dart';
import 'package:whereisit/models/ui_tag.model.dart';

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

  var tags = <UiTag>[
    UiTag(isSelected: false, isNew: false, item: 'Alaskan Malamute'),
    UiTag(isSelected: false, isNew: false, item: 'Bohemian Shepherd'),
    UiTag(isSelected: false, isNew: false, item: 'Cane Corso'),
    UiTag(isSelected: false, isNew: false, item: 'Dobermann'),
    UiTag(isSelected: false, isNew: false, item: 'English Mastiff'),
    UiTag(isSelected: false, isNew: false, item: 'Finnish Hound'),
    UiTag(isSelected: false, isNew: false, item: 'Great Dane'),
  ];
  var editedTags = <UiTag>[];
  var tagsToHandleBackNavigation = <UiTag>[];

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

  var filteredTagWithSearch = false;

  LatLng selectedLocation = const LatLng(
    -95.67127985317049,
    37.05311669685229,
  );

  _toggleTagSelection(dynamic event) {
    if (event is EditItemTagToggle) {
      var editedTagsCopy = <UiTag>[];
      for (var element in editedTags) {
        editedTagsCopy.add(
          UiTag(
            isNew: element.isNew,
            item: element.item,
            value: element.value,
            isSelected: element.isSelected,
          ),
        );
      }
      for (var i = 0; i < editedTagsCopy.length; i++) {
        if (editedTagsCopy[i].item == event.tag.item) {
          editedTags[i] = UiTag(
            isNew: event.tag.isNew,
            item: event.tag.item,
            isSelected: event.tag.isSelected ?? false,
            value: event.tag.value,
          );
        }
      }
    }
  }

  _buildItem(String event, Item item, List params) {
    Map<String, dynamic> itemParams = {
      'thumbnail': item.thumbnail,
      'uiTagsList': item.uiTagsList,
      'uiImagesList': item.uiImagesList,
      'uiSelectedCategory': item.uiSelectedCategory,
      'uiCardData': item.uiCardData,
      'uiTagCount': item.uiTagCount,
      'uiError': item.uiError,
      'uiCatSubcat': item.uiCatSubcat,
      'uiCoordinates': item.uiCoordinates,
      'uiSearchedAddresses': item.uiSearchedAddresses,
      'uiAddress': item.uiAddress,
      'uiSearchedProperties': item.uiSearchedProperties,
      'uiProperty': item.uiProperty,
    };

    switch (event) {
      case EditItemImageAdd.name:
        if (item.uiImagesList != null && item.uiImagesList!.isNotEmpty) {
          itemParams['uiImagesList'].add(params[0]);
        }
        if (item.uiImagesList != null) {
          itemParams['thumbnail'] = params[0];
          itemParams['uiImagesList'].add(params[0]);
        }
        break;
      case EditItemImageRemove.name:
        if (params.length == 2) {
          itemParams['thumbnail'] = params[0];
          itemParams['uiImagesList'] = params[1];
        }
        if (params.length == 1) {
          itemParams['uiImagesList'] = params[0];
        }
        break;
      case EditItemFavoriteLabel.name:
        itemParams['uiCardData'] = params[0];
        break;
      case EditItemLoadExisting.name:
        itemParams['id'] = params[0];
        itemParams['name'] = params[1];
        itemParams['thumbnail'] = params[2];
        itemParams['createdAt'] = params[3];
        itemParams['favorite'] = params[4];
        itemParams['uiTagsList'] = params[5];
        itemParams['uiImagesList'] = params[6];
        itemParams['uiCardData'] = params[7];
        break;
      case EditItemExisting.name:
        itemParams['uiCardData'] = params[0];
        break;
      case EditItemNewAdd.name:
        itemParams['uiCardData'] = params[0];
        break;
      case EditItemNewFirstImage.name:
        itemParams['thumbnail'] = params[0];
        itemParams['uiTagsList'] = <UiTag>[];
        itemParams['uiImagesList'] = params;
        itemParams['uiSelectedCategory'] = '';
        break;
      case EditItemCategoryNew.name:
        itemParams['uiCatSubcat'] = params[0];
        break;
      case EditItemCategoryLoad.name:
        itemParams['uiCatSubcat'] = params[0];
        break;
      case EditItemCategorySelect.name:
        itemParams['uiSelectedCategory'] = params[0];
        break;
      case EditItemSubcategorySelect.name:
        itemParams['uiSelectedCategory'] = params[0];
        break;
      case EditItemSubcategoryAdd.name:
        itemParams['uiCatSubcat'] = params[0];
        break;
      case EditItemCategoryUpdateInitial.name:
        itemParams['uiCatSubcat'] = params[0];
        break;
      case EditItemCategoryUpdate.name:
        itemParams['uiSelectedCategory'] = params[0];
        break;
      case EditItemTagInitial.name:
        itemParams['uiTagsList'] = params[0];
        break;
      case EditItemTagSearch.name:
        itemParams['uiTagsList'] = params[0];
        break;
      case EditItemTagToggle.name:
        itemParams['uiTagsList'] = params[0];
        break;
      case EditItemTagAdd.name:
        itemParams['uiTagsList'] = params[0];
        break;
      case EditItemTagUpdateCount.name:
        itemParams['uiTagCount'] = params[0];
        break;
      case EditItemTagSelectIgnore.name:
        itemParams['uiTagsList'] = params[0];
        itemParams['uiTagCount'] = params[1];
        break;
      case EditItemTagDelete.name:
        itemParams['uiTagsList'] = params[0];
        break;
      case EditItemLocationSelectIgnore.name:
        itemParams['uiCoordinates'] = params[0];
        break;
      case EditItemLocationSelected.name:
        itemParams['uiCoordinates'] = params[0];
        break;
      case EditItemAddressLoad.name:
        itemParams['uiSearchedAddresses'] = params[0];
        break;
      case EditItemAddressSearch.name:
        itemParams['uiSearchedAddresses'] = params[0];
        itemParams['uiAddress'] = params[1];
        break;
      case EditItemAddressSelect.name:
        itemParams['uiSearchedAddresses'] = params[0];
        itemParams['uiAddress'] = params[1];
        break;
      case EditItemAddressSelectIgnore.name:
        itemParams['uiSearchedAddresses'] = params[0];
        break;
      case EditItemPropertyLoad.name:
        itemParams['uiSearchedProperties'] = params[0];
        break;
      case EditItemPropertySearch.name:
        itemParams['uiSearchedProperties'] = params[0];
        itemParams['uiProperty'] = params[1];
        break;
      case EditItemPropertySelect.name:
        itemParams['uiSearchedProperties'] = params[0];
        itemParams['uiProperty'] = params[1];
        break;
      case EditItemPropertySelectIgnore.name:
        itemParams['uiSearchedProperties'] = params[0];
        break;
      default:
        return;
    }

    return Item.forUi(itemParams);
  }

  EditItemBloc(Item item) : super(EditItemInitial(item)) {
    on<EditItemImageAdd>(
      (event, emit) {
        item = _buildItem(EditItemImageAdd.name, item, [event.imagePath]);

        emit(EditItemImageAddSuccess(item));
      },
    );

    on<EditItemImageRemove>(
      (event, emit) {
        var temp = <String>[];
        if (item.uiImagesList != null) {
          temp = [...item.uiImagesList!];
        }
        temp.remove(event.imagePath);
        if (temp.isEmpty) {
          item = _buildItem(EditItemImageRemove.name, item, ['', []]);
        } else {
          item = _buildItem(EditItemImageRemove.name, item, [temp]);
        }

        emit(EditItemImageRemoveSuccess(item));
      },
    );

    on<EditItemFavoriteLabel>((event, emit) {
      var cardData = event.itemData;

      for (var element in list) {
        if (element.id == cardData.id) {
          element.isFavorite = cardData.isFavorite;
        }
      }

      item = _buildItem(EditItemFavoriteLabel.name, item, [cardData]);

      emit(EditItemFavoriteLabelSuccess(item));
    });

    on<EditItemLoadExisting>(
      (event, emit) {
        for (var element in list) {
          if (element.id == event.id.toString()) {
            item = _buildItem(
              EditItemLoadExisting.name,
              item,
              // TODO: Handle imagesList, location, quantity
              [
                element.id,
                element.title,
                element.imageSrc,
                element.createdAt,
                element.isFavorite ?? false,
                element.tags,
                [element.imageSrc],
                element,
              ],
            );

            emit(EditItemLoadExistingSuccess(item));
          }
        }
      },
    );

    on<EditItemExisting>((event, emit) {
      var cardData = list.firstWhere(
        (element) => element.id == event.id.toString(),
      );

      for (var element in list) {
        if (element.id == cardData.id) {
          element = CardData(
            id: cardData.id,
            title: cardData.title,
            imageSrc: cardData.imageSrc,
            location: cardData.location,
            qty: cardData.qty,
            tags: cardData.tags,
            createdAt: cardData.createdAt,
            isFavorite: cardData.isFavorite ?? false,
          );
          item = _buildItem(EditItemExisting.name, item, [element]);
        }
      }

      emit(EditItemFavoriteLabelSuccess(item));
    });

    on<EditItemNewAdd>((event, emit) {
      var cardData = CardData(
        id: event.itemData.id,
        title: event.itemData.title,
        imageSrc: event.itemData.imageSrc,
        location: event.itemData.location,
        qty: event.itemData.qty,
        tags: event.itemData.tags,
        createdAt: event.itemData.createdAt,
        isFavorite: false,
      );

      list.add(cardData);

      item = _buildItem(EditItemNewAdd.name, item, [cardData]);

      emit(EditItemNewAddSuccess(item));
    });

    on<EditItemNewFirstImage>(
      (event, emit) {
        item = _buildItem(EditItemNewFirstImage.name, item, [event.image]);

        emit(EditItemNewInitial(item));
      },
    );

    on<EditItemCategoryNew>((event, emit) {
      var catSubcat = CatSubcat(
        categories: categories,
        subcategories: subCategories,
      );

      item = _buildItem(EditItemCategoryNew.name, item, [catSubcat]);

      emit(EditItemCategoryNewSuccess(item));
    });

    on<EditItemCategoryLoad>(
      (event, emit) {
        stringtoHandleCategoryBack = selectedCategorySubCategory;
        var catSubcat = CatSubcat(
          categories: categories,
          subcategories: subCategories,
        );

        item = _buildItem(EditItemCategoryLoad.name, item, [catSubcat]);

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

        item = _buildItem(
          EditItemCategorySelect.name,
          item,
          [selectedCategorySubCategory],
        );

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

        item = _buildItem(
          EditItemSubcategorySelect.name,
          item,
          [selectedCategorySubCategory],
        );

        emit(EditItemCategorySelectSuccess(item));
      },
    );

    on<EditItemCategoryAdd>(
      (event, emit) {
        categories.add(event.category);

        emit(EditItemCategoryAddSuccess(item));
      },
    );

    on<EditItemSubcategoryAdd>(
      (event, emit) {
        if (event.subCategory.length == 1) {
          var hasCategory = false;

          hasCategory = categories.any(
            (element) => element == event.subCategory.keys.first,
          );

          if (!hasCategory) {
            categories.add(event.subCategory.keys.first);
          }

          if (event.subCategory.values.isNotEmpty) {
            event.subCategory.forEach((key, value) {
              subCategories[key] = value;
            });
          }

          var catSubcat = CatSubcat(
            categories: categories,
            subcategories: subCategories,
          );

          item = _buildItem(EditItemSubcategoryAdd.name, item, [catSubcat]);

          emit(EditItemCategoryLoadSuccess(item));
        }
      },
    );

    on<EditItemCategoryUpdateInitial>(
      (event, emit) {
        var catSubcat = CatSubcat(
          categories: categories,
          subcategories: subCategories,
        );

        item = _buildItem(
          EditItemCategoryUpdateInitial.name,
          item,
          [catSubcat],
        );

        emit(EditItemCategoryUpdateInitialSuccess(item));
      },
    );

    on<EditItemCategoryChange>(
      (event, emit) {
        var entry = event.newCategory.entries.first;
        editedCategory[entry.key] = entry.value;
        editedSubcategory[entry.key] = subCategories[entry.key] ?? [];

        emit(EditItemCategoryChangeSuccess(item));
      },
    );

    on<EditItemSubcategoryChange>(
      (event, emit) {
        var entry = event.newSubcategory.entries.first;
        var afterSplit = entry.key.split(':');
        var index = int.parse(afterSplit[0]);
        var category = afterSplit[1];

        editedSubcategory[category] = [...?subCategories[category]];
        if (editedSubcategory[category] != null) {
          editedSubcategory[category]![index] = entry.value;
        }

        emit(EditItemCategoryChangeSuccess(item));
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
              if (editedSubcategory[itemExistingCategory] != null) {
                toBeUpdatedItemSubcategory =
                    editedSubcategory[itemExistingCategory]![subCategoryIndex];
              }
            }
            // Then remove the key
            subCategories.remove(element.key);
            // Then add the new key with new value
            if (editedCategory[element.key] != null) {
              subCategories[editedCategory[element.key]!] = element.value;
            }
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

        item = _buildItem(
          EditItemCategoryUpdate.name,
          item,
          [selectedCategorySubCategory],
        );

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

          emit(EditItemSubcategoryUpdateSuccess(item));
        }
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
              UiTag(
                isNew: element.isNew,
                item: element.item,
                isSelected: element.isSelected,
                value: element.value,
              ),
            );
            tagsToHandleBackNavigation.add(
              UiTag(
                isNew: element.isNew,
                item: element.item,
                isSelected: element.isSelected,
                value: element.value,
              ),
            );
          }
        }

        item = _buildItem(EditItemTagInitial.name, item, [editedTags]);

        emit(EditItemTagToggleSuccess(item));
      },
    );

    on<EditItemTagSearch>(
      (event, emit) {
        var exists = false;
        var tempTags = <UiTag>[];

        for (var element in editedTags) {
          var elementItemInLowerCase = element.item.toLowerCase();
          var eventItemInLowerCase = event.tag.toLowerCase();
          if (elementItemInLowerCase.contains(eventItemInLowerCase)) {
            exists = true;
            tempTags.add(element);
          }
        }

        if (!exists) {
          tempTags = [
            UiTag(
              isNew: true,
              item: '+ Add "${event.tag}" to list',
              isSelected: false,
              value: event.tag,
            ),
            ...tempTags,
          ];
        }

        item = _buildItem(EditItemTagSearch.name, item, [tempTags]);

        filteredTagWithSearch = true;
        emit(EditItemTagSearchSuccess(item));
      },
    );

    on<EditItemTagToggle>(
      (event, emit) {
        _toggleTagSelection(event);

        item = _buildItem(
          EditItemTagToggle.name,
          item,
          [
            filteredTagWithSearch ? [event.tag] : editedTags,
          ],
        );

        emit(EditItemTagToggleSuccess(item));
        filteredTagWithSearch = false;
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
          UiTag(
            isSelected: false,
            isNew: false,
            item: event.tag != null && event.tag!.value != null
                ? event.tag!.value!
                : '',
          ),
        );
        var selectedTag = UiTag(
          isSelected: true,
          isNew: false,
          item: event.tag != null && event.tag!.value != null
              ? event.tag!.value!
              : '',
        );
        editedTags.add(selectedTag);
        selectedTagCount++;

        item = _buildItem(
          EditItemTagAdd.name,
          item,
          [
            [selectedTag],
          ],
        );

        emit(EditItemTagToggleSuccess(item));
        filteredTagWithSearch = false;
      },
    );

    on<EditItemTagUpdateCount>(
      (event, emit) {
        event.count > 0 ? selectedTagCount++ : selectedTagCount--;

        item = _buildItem(
          EditItemTagUpdateCount.name,
          item,
          [selectedTagCount],
        );

        emit(EditItemTagsOnSelectionCountUpdateSuccess(item));
      },
    );

    on<EditItemTagsSelected>(
      (event, emit) {
        item.uiTagsList = <UiTag>[];
        tagsToHandleBackNavigation = <UiTag>[];
        for (var element in editedTags) {
          tagsToHandleBackNavigation.add(
            UiTag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
          if (item.uiTagsList != null) {
            item.uiTagsList!.add(
              UiTag(
                isNew: element.isNew,
                item: element.item,
                isSelected: element.isSelected,
                value: element.value,
              ),
            );
          }
        }
        emit(EditItemTagsSelectionSuccess(item));
      },
    );

    on<EditItemTagSelectIgnore>(
      (event, emit) {
        editedTags = <UiTag>[];
        selectedTagCount = 0;
        for (var element in tagsToHandleBackNavigation) {
          if (element.isSelected != null && element.isSelected!) {
            selectedTagCount++;
          }
          editedTags.add(
            UiTag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
        }

        item = _buildItem(
          EditItemTagSelectIgnore.name,
          item,
          [editedTags, selectedTagCount],
        );

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
        editedTags[index] = UiTag(
          isNew: editedTags[index].isNew,
          item: editedTags[index].item,
          isSelected: false,
          value: editedTags[index].value,
        );
        item.uiTagsList = <UiTag>[];
        tagsToHandleBackNavigation = <UiTag>[];
        for (var element in editedTags) {
          tagsToHandleBackNavigation.add(
            UiTag(
              isNew: element.isNew,
              item: element.item,
              isSelected: element.isSelected,
              value: element.value,
            ),
          );
          if (item.uiTagsList != null) {
            item.uiTagsList!.add(
              UiTag(
                isNew: element.isNew,
                item: element.item,
                isSelected: element.isSelected,
                value: element.value,
              ),
            );
          }
        }
        selectedTagCount--;
        emit(EditItemTagsSelectionSuccess(item));
      },
    );

    on<EditItemTagDelete>(
      (event, emit) {
        tags.removeWhere((element) => element.item == event.tag.item);
        editedTags.removeWhere((element) => element.item == event.tag.item);
        if (item.uiTagsList != null) {
          item.uiTagsList!.removeWhere(
            (element) => element.item == event.tag.item,
          );
        }
        tagsToHandleBackNavigation.removeWhere(
          (element) => element.item == event.tag.item,
        );
        if (event.tag.isSelected != null && event.tag.isSelected!) {
          selectedTagCount--;
        }

        item = _buildItem(EditItemTagDelete.name, item, [editedTags]);

        emit(EditItemTagToggleSuccess(item));
      },
    );

    on<EditItemLocationLoad>((event, emit) {
      // emit(LocationLoadSuccess(selectedLocation));
      emit(EditItemLocationLoadSuccess(item));
    });

    on<EditItemLocationSelectIgnore>((event, emit) {
      LatLng coordinatesTwoDecimal = LatLng(
        double.parse(selectedLocation.latitude.toStringAsFixed(2)),
        double.parse(selectedLocation.longitude.toStringAsFixed(2)),
      );

      item = _buildItem(
        EditItemLocationSelectIgnore.name,
        item,
        [coordinatesTwoDecimal],
      );

      emit(EditItemLocationSelectIgnoreSuccess(item));
    });

    on<EditItemLocationSelected>((event, emit) {
      selectedLocation = event.location;

      LatLng coordinatesTwoDecimal = LatLng(
        double.parse(selectedLocation.latitude.toStringAsFixed(2)),
        double.parse(selectedLocation.longitude.toStringAsFixed(2)),
      );

      item = _buildItem(
        EditItemLocationSelected.name,
        item,
        [coordinatesTwoDecimal],
      );

      emit(EditItemLocationSelectSuccess(item));
    });

    on<EditItemAddressLoad>((event, emit) {
      var addresses = <String>[];

      for (var element in list) {
        addresses.add(element.location);
      }

      item = _buildItem(EditItemAddressLoad.name, item, [addresses]);

      emit(EditItemAddressLoadSuccess(item));
    });

    on<EditItemAddressSearch>((event, emit) {
      var filtered = <String>[];

      for (var element in list) {
        if (element.location.contains(event.searchString)) {
          filtered.add(element.location);
        }
      }

      // TODO: Handle Back button
      item = _buildItem(
        EditItemAddressSearch.name,
        item,
        [
          filtered,
          filtered.isEmpty
              ? '+ Add ${event.searchString} to list'
              : item.uiAddress,
        ],
      );

      emit(EditItemAddressSearchSuccess(item));
    });

    on<EditItemAddressSelect>((event, emit) {
      item = _buildItem(EditItemAddressSelect.name, item, [[], event.address]);

      emit(EditItemAddressSelectionSuccess(item));
    });

    on<EditItemAddressSelectIgnore>((event, emit) {
      var addresses = <String>[];

      for (var element in list) {
        addresses.add(element.location);
      }

      item = _buildItem(EditItemAddressSelectIgnore.name, item, [addresses]);

      emit(EditItemAddressSelectIgnoreSuccess(item));
    });

    on<EditItemPropertyLoad>((event, emit) {
      var properties = <String>[];

      // TODO: Handle property
      item = _buildItem(EditItemPropertyLoad.name, item, [properties]);

      emit(EditItemPropertyLoadSuccess(item));
    });

    on<EditItemPropertySearch>((event, emit) {
      var filtered = <String>[];

      // TODO: Handle property filter

      // TODO: Handle Back button
      item = _buildItem(
        EditItemPropertySearch.name,
        item,
        [
          filtered,
          filtered.isEmpty
              ? '+ Add ${event.searchString} to list'
              : item.uiAddress,
        ],
      );

      emit(EditItemPropertySearchSuccess(item));
    });

    on<EditItemPropertySelect>((event, emit) {
      item = _buildItem(
        EditItemPropertySelect.name,
        item,
        [[], event.property],
      );

      emit(EditItemPropertySelectionSuccess(item));
    });

    on<EditItemPropertySelectIgnore>((event, emit) {
      var properties = <String>[];

      // TODO: Handle Property
      item = _buildItem(EditItemPropertySelectIgnore.name, item, [properties]);

      emit(EditItemPropertySelectIgnoreSuccess(item));
    });

    on<EditItemSubmit>(
      (event, emit) {
        // TODO: Handle save to Db

        imageList = <String>[];
        editedTags = <UiTag>[];
        tagsToHandleBackNavigation = <UiTag>[];
        selectedTagCount = 0;
        editedCategory = <String, String>{};
        editedSubcategory = <String, List<String>>{};
        selectedCategorySubCategory = '';
        stringtoHandleCategoryBack = '';
        filteredTagWithSearch = false;
        selectedLocation = const LatLng(
          -95.67127985317049,
          37.05311669685229,
        );
        item = Item.forUi({});

        emit(EditItemSubmitSuccess(item));
      },
    );
  }
}
