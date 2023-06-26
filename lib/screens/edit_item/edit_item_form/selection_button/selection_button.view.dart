import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/selection_button_type.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonType = <SelectionButtonType, dynamic>{
      SelectionButtonType.category: {
        "buildWhen": (_, current) =>
            current is EditItemCategorySelectSuccess ||
            current is EditItemCategoryUpdateSuccess,
        "stateEvaluationCondition": state.item.uiSelectedCategory != null &&
            state.item.uiSelectedCategory!.isNotEmpty,
        "unSelectedButtonText": 'Select a category',
        "unSelectedButtonIcon": Icons.add_rounded,
        "onButtonPressed": () {
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

    return Row(
      children: [
        Expanded(
          child: BlocBuilder<EditItemBloc, EditItemState>(
            buildWhen: buttonType[SelectionButtonType.category]["buildWhen"],
            builder: (context, state) {
              if (state.item.uiSelectedCategory != null &&
                  state.item.uiSelectedCategory!.isNotEmpty) {
                return TextButton(
                  onPressed: buttonType[SelectionButtonType.category]
                      ["onButtonPressed"],
                  child: Text(
                    'Category: ${state.item.uiSelectedCategory}',
                  ),
                );
              }
              return TextButton.icon(
                icon: Icon(
                  buttonType[SelectionButtonType.category]
                      ["unSelectedButtonIcon"],
                ),
                onPressed: buttonType[SelectionButtonType.category]
                    ["onButtonPressed"],
                label: Text(
                  buttonType[SelectionButtonType.category]
                      ["unSelectedButtonText"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
