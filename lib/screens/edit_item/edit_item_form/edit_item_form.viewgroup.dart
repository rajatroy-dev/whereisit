import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/list_item.model.dart';
import 'package:whereisit/screens/edit_item/text_input/text_input.view.dart';
import 'package:whereisit/screens/map_location_selector/map_location_selector.screen.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/validators/input_validator.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';

class EditItemForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _imageList = <String>[];

  final void Function() imageSourceChoiceHandler;
  final TextEditingController addressController;

  EditItemForm({
    Key? key,
    required this.imageSourceChoiceHandler,
    required this.addressController,
  }) : super(key: key);

  List<Widget> _buildTagsList(List<ListItem> tags) {
    var pillTagsList = <Widget>[];
    for (var element in tags) {
      pillTagsList.add(PillTag(
        title: '#${element.item}',
        isShort: false,
        hasDelete: true,
      ));
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
            HorizontalImageListContainer(
              images: _imageList,
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
            const TextInput(
              labelText: 'Name',
              hintText: 'Name of the item',
              validator: InputValidator.name,
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
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.add_location_alt_rounded,
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      MapLocationSelector.routeName,
                    ).then(
                      (value) => extractAddressAndCoordinate(
                        value as String,
                      ),
                    ),
                    label: coordinates.isEmpty
                        ? const Text('Select a location from Maps')
                        : Text(coordinates),
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
                      children: _buildTagsList(state.items),
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