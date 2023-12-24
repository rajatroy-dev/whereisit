import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/screens/map_location_selector/map_location_selector.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/selection_button_state.enum.dart';
import 'package:whereisit/shared/enums/selection_button_type.enum.dart';

class SelectionButton extends StatelessWidget {
  final SelectionButtonType buttonType;
  final SelectionButtonState buttonState;
  final String? buttonText;

  const SelectionButton({
    super.key,
    required this.buttonType,
    required this.buttonState,
    this.buttonText,
  }) : assert(
          (buttonState == SelectionButtonState.noValue && buttonText == null) ||
              (buttonState == SelectionButtonState.hasValue &&
                  buttonText != null),
          'Button state is selected but button text was not provided!',
        );

  @override
  Widget build(BuildContext context) {
    final buttons = <SelectionButtonType, dynamic>{
      SelectionButtonType.category: {
        "selectedLabel": 'Category: $buttonText',
        "unselectedLabel": 'Select a category',
        "icon": Icons.category_rounded,
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
        "selectedLabel": '$buttonText',
        "unselectedLabel": 'Select a location from Maps',
        "icon": Icons.add_location_alt_rounded,
        "onPressed": () {
          Navigator.pushNamed(
            context,
            MapLocationSelector.routeName,
          );
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemLocationLoad(),
          );
        },
      }
    };

    return TextButton.icon(
      icon: Icon(buttons[buttonType]["icon"]),
      onPressed: buttons[buttonType]["onPressed"],
      label: buttonState == SelectionButtonState.noValue
          ? Text(
              buttons[buttonType]["unselectedLabel"],
            )
          : Text(
              buttons[buttonType]["selectedLabel"],
            ),
    );
  }
}
