import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/selection_button_state.enum.dart';
import 'package:whereisit/shared/enums/selection_button_type.enum.dart';

class SelectionButton extends StatelessWidget {
  final SelectionButtonType buttonType;
  final SelectionButtonState buttonState;
  final String? buttonText;

  const SelectionButton({
    Key? key,
    required this.buttonType,
    required this.buttonState,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonType = <SelectionButtonType, dynamic>{
      SelectionButtonType.category: {
        "selectedButtonText": 'Category: $buttonText',
        "label": 'Select a category',
        "icon": Icons.add_rounded,
        "onPressed": () {
          Navigator.pushNamed(
            context,
            CategorySubcategoryScreen.routeName,
          );
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemCategoryLoad(),
          );
        },
      },
      SelectionButtonType.location: {
        "selectedButtonText": 'Category: $buttonText',
        "unSelectedButtonText": 'Select a category',
        "unSelectedButtonIcon": Icons.add_rounded,
        "onPressed": () {
          Navigator.pushNamed(
            context,
            CategorySubcategoryScreen.routeName,
          );
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemCategoryLoad(),
          );
        },
      }
    };

    return TextButton.icon(
      icon: Icon(
        buttonType[buttonType]["unSelectedButtonIcon"],
      ),
      onPressed: buttonType[buttonType]["onPressed"],
      label: Text(
        buttonType[buttonType]["unSelectedButtonText"],
      ),
    );
  }
}
