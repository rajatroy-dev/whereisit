import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class AddEditCategoryScreen extends StatefulWidget {
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
              child: ListView.builder(
                itemCount: subCategoriesList.length,
                itemBuilder: (context, index) {
                  return TextFormField(
                    initialValue: subCategoriesList[index],
                    onChanged: (value) => _handleChange(index, value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
