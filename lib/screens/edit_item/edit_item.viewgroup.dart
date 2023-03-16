import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereisit/screens/edit_item/text_input/text_input.view.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/validators/input_validator.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';
import 'package:whereisit/shared/widgets/image_source_choice/image_source_choice_popup.dart';
import 'package:whereisit/screens/map_location_selector/map_location_selector.screen.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';
import 'package:whereisit/shared/widgets/single_child_scroll_view_mod/single_child_scroll_view_mod.viewgroup.dart';

class EditItem extends StatefulWidget {
  static const routeName = '/edit-item';

  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();

  var imageList = <String>[];
  var showImageSourceChoice = false;
  var coordinates = '';

  handleAddImage() {
    setState(() {
      showImageSourceChoice = true;
    });
  }

  saveImage(XFile image) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    var path = '${tempDir.path}/${image.name}';
    image.saveTo(path);
    var temp = imageList;
    temp.add(path);
    setState(() {
      imageList = temp;
      showImageSourceChoice = false;
    });
  }

  handleImageSourceSelection(SourceChoice choice) async {
    ImagePicker picker = ImagePicker();

    switch (choice) {
      case SourceChoice.gallery:
        var image = await picker.pickImage(source: ImageSource.gallery);
        await saveImage(image!);
        break;
      case SourceChoice.camera:
        var image = await picker.pickImage(source: ImageSource.camera);
        await saveImage(image!);
        break;
      case SourceChoice.none:
        setState(() {
          showImageSourceChoice = false;
        });
        return;
      default:
        break;
    }
  }

  extractAddressAndCoordinate(String value) {
    // format: address=alsdalksd&coordinates=12.12,123.123
    var locationDetails = value.split('&');

    var temp = <String, String>{};
    var firstKey = locationDetails[0].split('=');
    temp[firstKey[0]] = firstKey[1];
    var secondKey = locationDetails[1].split('=');
    temp[secondKey[0]] = secondKey[1];

    if (temp['address'] != null && temp['address']!.isNotEmpty) {
      _addressController.text = temp['address']!;
    }

    if (temp['coordinates'] != null && temp['coordinates']!.isNotEmpty) {
      setState(() {
        coordinates = temp['coordinates']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      var routeArgs = args as RouteArguments;
      if (routeArgs.hasParams && routeArgs.params!.containsKey('id')) {
        BlocProvider.of<EditItemBloc>(context).add(
          EditItemAll(routeArgs.params!['id']!),
        );
      }
      if (routeArgs.hasParams &&
          routeArgs.params!.containsKey('image') &&
          imageList.isEmpty) {
        var temp = imageList;
        getApplicationDocumentsDirectory().then((tempDir) {
          temp.add('${tempDir.path}/${routeArgs.params!['image']!}');
          setState(() {
            imageList = temp;
          });
        });
      }
    }

    return AppScaffold(
      body: Stack(
        children: [
          SingleChildScrollViewMod(
            child: BlocBuilder<EditItemBloc, EditItemState>(
              builder: (context, state) {
                if (state is EditItemAllSuccess) {
                  return Wrap(
                    children: const [
                      PillTag(
                        title: '# This is a very large tag',
                        isShort: false,
                      ),
                      PillTag(
                        title: '# This is a large tag',
                        isShort: false,
                      ),
                      PillTag(
                        title: '# This is a large tag',
                        isShort: false,
                      ),
                      PillTag(
                        title: '# This is a large tag',
                        isShort: false,
                      ),
                    ],
                  );
                }

                if (imageList.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HorizontalImageListContainer(
                            images: imageList,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: handleAddImage,
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
                              controller: _addressController,
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
                                      ? const Text(
                                          'Select a location from Maps')
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
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              children: const [
                                PillTag(
                                  title: '#abcdef',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#ghijkl',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#mnopqr',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#stuvwx',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#abcdef',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#ghijkl',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#mnopqr',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#stuvwx',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#abcdef',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#ghijkl',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#mnopqr',
                                  isShort: false,
                                ),
                                PillTag(
                                  title: '#stuvwx',
                                  isShort: false,
                                ),
                              ],
                            ),
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
                return const Center(
                  child: Text('Something Went Wrong!'),
                );
              },
            ),
          ),
          if (showImageSourceChoice)
            ImageSourceChoicePopup(
              handler: handleImageSourceSelection,
            ),
        ],
      ),
    );
  }
}
