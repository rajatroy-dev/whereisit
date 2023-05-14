import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/accordian/accordian.view.dart';
import 'package:whereisit/screens/category_subcategory/add_edit_category/add_edit_category.view.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class CategorySubcategoryScreen extends StatelessWidget {
  static const routeName = '/select-category';

  const CategorySubcategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<EditItemBloc>(context).add(
          EditItemCategoryEditIgnore(),
        );
        return true;
      },
      child: BlocConsumer<EditItemBloc, EditItemState>(
        listenWhen: (previous, current) =>
            current is EditItemCategorySelectSuccess ||
            current is EditItemCategoryUpdateSuccess,
        listener: (context, state) => Navigator.pop(context),
        buildWhen: (previous, current) =>
            current is EditItemCategoryLoadSuccess ||
            current is EditItemCategoryNewSuccess ||
            current is EditItemCategoryUpdateInitialSuccess,
        builder: (context, state) {
          if (state is EditItemCategoryLoadSuccess) {
            return AppScaffold(
              action: AppBarAction.addCategory,
              body: ListView.builder(
                itemCount: state.item.categories.length,
                itemBuilder: (context, index) {
                  var category = state.item.categories[index];
                  var subCategories = state.item.subcategories[category];
                  return Accordion(
                    title: category,
                    content: subCategories ?? [],
                    isOnlyCategory:
                        subCategories == null || subCategories.isEmpty,
                  );
                },
              ),
            );
          }

          if (state is EditItemCategoryUpdateInitialSuccess) {
            return AppScaffold(
              action: AppBarAction.editCategory,
              body: ListView.builder(
                itemCount: state.item.categories.length,
                itemBuilder: (context, index) {
                  var category = state.item.categories[index];
                  var subCategories = state.item.subcategories[category];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Accordion(
                      title: category,
                      content: subCategories ?? [],
                      isEditable: true,
                      isOnlyCategory:
                          subCategories == null || subCategories.isEmpty,
                    ),
                  );
                },
              ),
            );
          }

          if (state is EditItemCategoryNewSuccess) {
            return const AddEditCategoryScreen();
          }

          return const SizedBox();
        },
      ),
    );
  }
}
