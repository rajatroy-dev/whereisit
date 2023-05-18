import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class AddCategory extends StatefulWidget {
  static const routeName = '/add-edit-category';

  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var categoryController = TextEditingController();
  var subCategoriesList = <int, String>{
    0: '',
    1: '',
  };

  _handleSubmit() {
    var payload = <String, List<String>>{};
    var subCategories = <String>[];

    for (var element in subCategoriesList.entries) {
      subCategories.add(element.value);
    }

    payload[categoryController.text] = subCategories;

    BlocProvider.of<EditItemBloc>(context).add(EditItemSubCategoryAdd(payload));
  }

  Widget _buildList(ScrollController scrollController) {
    var columnList = <Widget>[];

    columnList.add(
      Padding(
        padding: const EdgeInsets.only(
          top: 70.0,
          right: 20.0,
          bottom: 25.0,
          left: 20.0,
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Category',
          ),
          controller: categoryController,
        ),
      ),
    );

    var index = 0;
    for (var element in subCategoriesList.entries) {
      columnList.add(
        Padding(
          padding: const EdgeInsets.only(left: 40.0, bottom: 20.0, right: 20.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Sub category ${index + 1}',
            ),
            initialValue: subCategoriesList[element.key],
            onChanged: (value) => _handleChange(element.key, value),
          ),
        ),
      );
      index++;
    }

    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: columnList,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.purple,
                      child: IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.purple,
                      child: IconButton(
                        icon: const Icon(Icons.check_rounded),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .3,
      maxChildSize: .5,
      builder: (BuildContext context, ScrollController scrollController) {
        return _buildList(scrollController);
      },
    );
  }
}
