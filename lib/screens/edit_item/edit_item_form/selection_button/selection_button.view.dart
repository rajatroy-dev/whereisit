import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/selection_button_type.dart';

class SelectionButton extends StatelessWidget {
  final BuildContext context;
  final EditItemState state;
  final SelectionButtonType buttonType;

  const SelectionButton({
    Key? key,
    required this.context,
    required this.state,
    required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonType = <SelectionButtonType, dynamic>{
      SelectionButtonType.category: {
        "buildWhen": (_, current) =>
            current is EditItemCategorySelectSuccess ||
            current is EditItemCategoryUpdateSuccess,
        "stateEvaluationCondition": {
          "success": state.item.uiSelectedCategory != null &&
              state.item.uiSelectedCategory!.isNotEmpty,
          "failure": null,
          "ignore": null,
        },
        "selectedButtonText": 'Category: ${state.item.uiSelectedCategory}',
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
        "stateEvaluation": state.item.uiSelectedCategory != null &&
            state.item.uiSelectedCategory!.isNotEmpty,
      },
      SelectionButtonType.location: {
        "buildWhen": null,
        "stateEvaluationCondition": {
          "success": state is EditItemLocationSelectSuccess,
          "ignore": state is EditItemLocationSelectIgnoreSuccess,
          "failure": null,
        },
        "selectedButtonText": 'Category: ${state.item.uiSelectedCategory}',
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
        "stateEvaluation": state.item.uiSelectedCategory != null &&
            state.item.uiSelectedCategory!.isNotEmpty,
      }
    };

    return Row(
      children: [
        Expanded(
          child: BlocBuilder<EditItemBloc, EditItemState>(
            buildWhen: buttonType[buttonType]["buildWhen"],
            builder: (context, state) {
              if (buttonType[buttonType]["stateEvaluation"]["success"]) {
                return TextButton(
                  onPressed: buttonType[buttonType]["onButtonPressed"],
                  child: Text(
                    buttonType[buttonType]["selectedButtonText"],
                  ),
                );
              }
              return TextButton.icon(
                icon: Icon(
                  buttonType[buttonType]["unSelectedButtonIcon"],
                ),
                onPressed: buttonType[buttonType]["onButtonPressed"],
                label: Text(
                  buttonType[buttonType]["unSelectedButtonText"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
