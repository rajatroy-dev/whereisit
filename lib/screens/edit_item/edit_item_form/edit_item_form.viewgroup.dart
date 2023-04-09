import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/screens/edit_item/text_input/text_input.view.dart';
import 'package:whereisit/screens/map_location_selector/map_location_selector.screen.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/validators/input_validator.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';

class EditItemForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final void Function() imageSourceChoiceHandler;
  final TextEditingController addressController;
  final TextEditingController nameController;

  EditItemForm({
    Key? key,
    required this.imageSourceChoiceHandler,
    required this.addressController,
    required this.nameController,
  }) : super(key: key);

  List<Widget> _buildTagsList(List<Tag> tags, BuildContext context) {
    var pillTagsList = <Widget>[];
    for (var element in tags) {
      if (element.isSelected!) {
        pillTagsList.add(PillTag(
          title: '#${element.item}',
          isShort: false,
          hasDelete: true,
          handleDelete: () => BlocProvider.of<EditItemBloc>(context).add(
            EditItemTagRemove(element.item),
          ),
        ));
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
                  current is AddItemInitial ||
                  current is EditItemTagsSelectionSuccess ||
                  current is EditItemImageAddSuccess ||
                  current is EditItemImageRemoveSuccess,
              builder: (context, state) {
                var imagesList = <String>[];
                if (state is AddItemInitial) {
                  imagesList = state.item.uiImagesList!;
                } else if (state is EditItemTagsSelectionSuccess) {
                  imagesList = state.item.uiImagesList!;
                } else if (state is EditItemImageAddSuccess) {
                  imagesList = state.item.uiImagesList!;
                } else if (state is EditItemImageRemoveSuccess) {
                  imagesList = state.item.uiImagesList!;
                }
                if (imagesList.isNotEmpty) {
                  return HorizontalImageListContainer(
                    images: imagesList,
                  );
                }
                return const Center(child: Text('Something Went Wrong!'));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: imageSourceChoiceHandler,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('ADD MORE'),
                ),
              ],
            ),
            const TextInput(
              initialValue: '1',
              labelText: 'Quantity',
              hintText: 'How many items are you storing?',
              validator: InputValidator.quantity,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Focus(
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Name of the item',
                    labelText: 'Name',
                  ),
                  validator: InputValidator.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLines: 5,
                controller: addressController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Address where the item is stored',
                  labelText: 'Address',
                ),
                validator: InputValidator.address,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<LocationSearchBloc, LocationSearchState>(
                    buildWhen: (_, current) =>
                        current is LocationSelectionSuccess,
                    builder: (context, state) {
                      if (state is LocationSelectionSuccess) {
                        addressController.text =
                            state.addressAndCoordinates['address']!;
                        return TextButton.icon(
                          icon: const Icon(
                            Icons.add_location_alt_rounded,
                          ),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            MapLocationSelector.routeName,
                          ),
                          label: Text(
                            state.addressAndCoordinates['coordinates']!,
                          ),
                        );
                      }
                      return TextButton.icon(
                        icon: const Icon(
                          Icons.add_location_alt_rounded,
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          MapLocationSelector.routeName,
                        ),
                        label: const Text('Select a location from Maps'),
                      );
                    },
                  ),
                ),
              ],
            ),
            const TextInput(
              labelText: 'Property',
              hintText: 'E.g., home, office, etc.',
              validator: InputValidator.address,
            ),
            const TextInput(
              labelText: 'Room',
              hintText: 'E.g., bedroom, livingroom, etc.',
              validator: InputValidator.address,
            ),
            BlocBuilder<EditItemBloc, EditItemState>(
              builder: (context, state) {
                if (state is EditItemTagsSelectionSuccess) {
                  return SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      children: _buildTagsList(state.item.uiTagsList!, context),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    SearchWithDropdownScreen.routeName,
                  ),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('ADD MORE'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processing Data'),
                      ),
                    );
                  }
                },
                child: const Text('SUBMIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
