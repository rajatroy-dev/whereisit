import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/accordian/accordian.view.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class CategorySubcategoryScreen extends StatelessWidget {
  static const routeName = '/select-category';

  const CategorySubcategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: AppBarAction.addCategory,
      body: BlocConsumer<EditItemBloc, EditItemState>(
        listenWhen: (previous, current) =>
            current is EditItemCategorySelectSuccess,
        listener: (context, state) => Navigator.pop(context),
        buildWhen: (previous, current) =>
            current is EditItemCategoryLoadSuccess ||
            current is EditItemCategoryUpdateInitialSuccess,
        builder: (context, state) {
          if (state is EditItemCategoryLoadSuccess) {
            return ListView.builder(
              itemCount: state.item.uiCategoriesList!.length,
              itemBuilder: (context, index) {
                var category = state.item.uiCategoriesList![index];
                var subCategories = state.item.uiSubCategoriesList![category];
                return Accordion(title: category, content: subCategories!);
              },
            );
          }

          if (state is EditItemCategoryUpdateInitialSuccess) {
            return ListView.builder(
              itemCount: state.item.uiCategoriesList!.length,
              itemBuilder: (context, index) {
                var category = state.item.uiCategoriesList![index];
                var subCategories = state.item.uiSubCategoriesList![category];
                return Accordion(
                  title: category,
                  content: subCategories!,
                  isEditable: true,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
