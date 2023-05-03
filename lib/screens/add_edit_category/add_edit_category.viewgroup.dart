import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class AddEditCategoryScreen extends StatefulWidget {
  static const routeName = '/add-edit-category';

  const AddEditCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  var categoryController = TextEditingController();
  var subCategoriesList = <int, String>{
    0: '',
    1: '',
  };

  Widget _buildList() {
    var columnList = <Widget>[];

    for (var element in subCategoriesList.entries) {
      columnList.add(TextFormField(
        initialValue: subCategoriesList[element.key],
        onChanged: (value) => _handleChange(element.key, value),
      ));
    }

    return Column(
      children: columnList,
    );
  }

  _handleEditCateogry(String category) {
    BlocProvider.of<EditItemBloc>(context).add(
      EditItemCategoryUpdate(category),
    );
  }

  _handleChange(int index, String value) {
    var shouldAddNewfield = true;
    for (var element in subCategoriesList.entries) {
      if (element.value.isEmpty) {
        shouldAddNewfield = false;
        break;
      }
    }

    if (shouldAddNewfield) {
      var temp = {...subCategoriesList};
      temp[temp.length] = '';
      setState(() {
        subCategoriesList = temp;
        subCategoriesList[index] = value;
      });
    } else {
      setState(() {
        subCategoriesList[index] = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      _handleEditCateogry(args as String);
    }

    return AppScaffold(
      action: AppBarAction.addCategory,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: categoryController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }
}
