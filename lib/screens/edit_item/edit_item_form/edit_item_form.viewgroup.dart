import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/screens/map_location_selector/map_location_selector.screen.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/validators/input_validator.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';

class EditItemForm extends StatefulWidget {
  final void Function() imageSourceChoiceHandler;

  const EditItemForm({
    Key? key,
    required this.imageSourceChoiceHandler,
  }) : super(key: key);

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _formKey = GlobalKey<FormState>();

  var textInput = {
    'quantity': '1',
    'name': '',
    'address': '',
    'property': '',
    'room': '',
  };
  var isLocationSelected = false;

  final TextEditingController quantityController = TextEditingController()
    ..text = '1';

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController propertyController = TextEditingController();

  final TextEditingController roomController = TextEditingController();

  final validator = InputValidator();

  List<Widget> _buildTagsList(List<Tag>? tags, BuildContext context) {
    var notNulltags = <Tag>[];
    if (tags != null) notNulltags = tags;
    var pillTagsList = <Widget>[];
    for (var element in notNulltags) {
      if (element.isSelected != null && element.isSelected!) {
        pillTagsList.add(
          PillTag(
            title: '#${element.item}',
            isShort: false,
            hasDelete: true,
            handleDelete: () => BlocProvider.of<EditItemBloc>(context).add(
              EditItemTagRemove(element.item),
            ),
          ),
        );
      }
    }

    return pillTagsList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<EditItemBloc, EditItemState>(
              buildWhen: (previous, current) =>
                  current is EditItemNewInitial ||
                  current is EditItemTagsSelectionSuccess ||
                  current is EditItemImageAddSuccess ||
                  current is EditItemImageRemoveSuccess ||
                  current is EditItemCategorySelectSuccess,
              builder: (context, state) {
                var imagesList = state.item.uiImagesList != null
                    ? state.item.uiImagesList!
                    : <String>[];
                return HorizontalImageListContainer(
                  images: imagesList,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: widget.imageSourceChoiceHandler,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('ADD IMAGE'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: textInput['quantity'],
                onChanged: (value) => setState(() {
                  textInput['quantity'] = value;
                }),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'How many items are you storing?',
                  labelText: 'Quantity',
                ),
                validator: validator.quantity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Focus(
                child: TextFormField(
                  initialValue: textInput['name'],
                  onChanged: (value) => setState(() {
                    textInput['name'] = value;
                  }),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Name of the item',
                    labelText: 'Name',
                  ),
                  validator: validator.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLines: 5,
                initialValue: textInput['address'],
                onChanged: (value) => setState(() {
                  textInput['address'] = value;
                }),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Address where the item is stored',
                  labelText: 'Address',
                ),
                validator: validator.address,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<EditItemBloc, EditItemState>(
                    builder: (context, state) {
                      if (state is EditItemLocationSelectSuccess) {
                        isLocationSelected = true;
                        return TextButton.icon(
                          icon: const Icon(
                            Icons.add_location_alt_rounded,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              MapLocationSelector.routeName,
                            );
                            BlocProvider.of<EditItemBloc>(context).add(
                              EditItemLocationLoad(),
                            );
                          },
                          label: Text(
                            '${state.item.uiCoordinates?.latitude}, '
                            '${state.item.uiCoordinates?.longitude}',
                          ),
                        );
                      }
                      if (state is EditItemLocationSelectIgnoreSuccess) {
                        if (isLocationSelected) {
                          return TextButton.icon(
                            icon: const Icon(
                              Icons.add_location_alt_rounded,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                MapLocationSelector.routeName,
                              );
                              BlocProvider.of<EditItemBloc>(context).add(
                                EditItemLocationLoad(),
                              );
                            },
                            label: Text(
                              '${state.item.uiCoordinates?.latitude}, '
                              '${state.item.uiCoordinates?.longitude}',
                            ),
                          );
                        }
                      }
                      return TextButton.icon(
                        icon: const Icon(
                          Icons.add_location_alt_rounded,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            MapLocationSelector.routeName,
                          );
                          BlocProvider.of<EditItemBloc>(context).add(
                            EditItemLocationLoad(),
                          );
                        },
                        label: const Text('Select a location from Maps'),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<EditItemBloc, EditItemState>(
                    buildWhen: (_, current) =>
                        current is EditItemCategorySelectSuccess ||
                        current is EditItemCategoryUpdateSuccess,
                    builder: (context, state) {
                      if (state.item.uiSelectedCategory != null &&
                          state.item.uiSelectedCategory!.isNotEmpty) {
                        return TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              CategorySubcategoryScreen.routeName,
                            );
                            BlocProvider.of<EditItemBloc>(context).add(
                              EditItemCategoryLoad(),
                            );
                          },
                          child: Text(
                            'Category: ${state.item.uiSelectedCategory}',
                          ),
                        );
                      }
                      return TextButton.icon(
                        icon: const Icon(
                          Icons.add_rounded,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            CategorySubcategoryScreen.routeName,
                          );
                          BlocProvider.of<EditItemBloc>(context).add(
                            EditItemCategoryLoad(),
                          );
                        },
                        label: const Text('Select a category'),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: textInput['property'],
                onChanged: (value) => setState(() {
                  textInput['property'] = value;
                }),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'E.g., home, office, etc.',
                  labelText: 'Property',
                ),
                validator: validator.property,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: textInput['room'],
                onChanged: (value) => setState(() {
                  textInput['room'] = value;
                }),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'E.g., bedroom, livingroom, etc.',
                  labelText: 'Room',
                ),
                validator: validator.room,
              ),
            ),
            BlocBuilder<EditItemBloc, EditItemState>(
              buildWhen: (previous, current) =>
                  current is EditItemTagsSelectionSuccess,
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: _buildTagsList(state.item.uiTagsList, context),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  SearchWithDropdownScreen.routeName,
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text('ADD TAGS'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<EditItemBloc>(context).add(
                      EditItemSubmit(textInput),
                    );
                  }
                },
                child: const Text('SUBMIT'),
              ),
            ),
            BlocListener<EditItemBloc, EditItemState>(
              listener: (context, state) {
                if (state is EditItemSubmitSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saved successfully'),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
