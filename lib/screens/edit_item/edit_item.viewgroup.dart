import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/screens/edit_item/edit_item_form/edit_item_form.viewgroup.dart';
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

  List<Widget> _buildTagsList(List<Tag> tags) {
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
                if (state is AddItemInitial) {
                  if (state.item.uiImagesList!.isNotEmpty) {
                    return EditItemForm(
                      imageList: state.item.uiImagesList!,
                      imageSourceChoiceHandler: handleAddImage,
                      addressController: _addressController,
                    );
                  } else {
                    return const Center(child: Text('Something went wrong!'));
                  }
                }
                if (state is EditItemInitial) {
                  return EditItemForm(
                    imageList: [],
                    imageSourceChoiceHandler: handleAddImage,
                    addressController: _addressController,
                  );
                }

                if (state is EditItemTagsSelectionSuccess) {
                  return EditItemForm(
                    imageList: [],
                    imageSourceChoiceHandler: handleAddImage,
                    addressController: _addressController,
                  );
                }
                return const Center(child: CircularProgressIndicator());
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
