import 'package:flutter/material.dart';

class AddEditCategory extends StatefulWidget {
  static const routeName = '/add-edit-category';

  const AddEditCategory({Key? key}) : super(key: key);

  @override
  State<AddEditCategory> createState() => _AddEditCategoryState();
}

class _AddEditCategoryState extends State<AddEditCategory> {
  var categoryController = TextEditingController();
  var subCategoriesList = <int, String>{
    1: '',
    2: '',
  };

  Widget _buildList(ScrollController scrollController) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25.0,
          horizontal: 20,
        ),
        child: ListView.builder(
          controller: scrollController,
          itemCount: subCategoriesList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                  controller: categoryController,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Sub category $index',
                ),
                initialValue: subCategoriesList[index],
                onChanged: (value) => _handleChange(index, value),
              ),
            );
          },
        ),
      ),
    );

    // var columnList = <Widget>[];

    // for (var element in subCategoriesList.entries) {
    //   columnList.add(TextFormField(
    //     initialValue: subCategoriesList[element.key],
    //     onChanged: (value) => _handleChange(element.key, value),
    //   ));
    // }

    // return Column(
    //   children: columnList,
    // );
  }

  _handleEditCateogry(String category) {
    // BlocProvider.of<EditItemBloc>(context).add(
    //   EditItemCategoryUpdate(category),
    // );
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

    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .3,
      maxChildSize: .6,
      builder: (BuildContext context, ScrollController scrollController) {
        return _buildList(scrollController);
      },
    );
  }
}
