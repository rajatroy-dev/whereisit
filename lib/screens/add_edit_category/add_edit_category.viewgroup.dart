import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class AddEditCategoryScreen extends StatefulWidget {
  const AddEditCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  var subCategoriesList = <String, String>{
    '0': '',
    '1': '',
  };

  ListView _buildListOfSubCategories() {
    var listLength = subCategoriesList.length;
    var shouldAddNewfield = true;
    for (var element in subCategoriesList.entries) {
      if (element.value.isEmpty) {
        shouldAddNewfield = false;
        break;
      }
    }

    if (shouldAddNewfield) {
      return ListView.builder(
        itemCount: subCategoriesList.length + 1,
        itemBuilder: (context, index) {
          if (index == listLength) {
            return TextFormField();
          }
          return TextFormField(
            initialValue: subCategoriesList[index],
          );
        },
      );
    }
    return ListView.builder(
      itemCount: subCategoriesList.length,
      itemBuilder: (context, index) {
        return TextFormField(
          initialValue: subCategoriesList[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: AppBarAction.addCategory,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: _buildListOfSubCategories(),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('+ Add more'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
