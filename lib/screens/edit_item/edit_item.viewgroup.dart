import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereisit/shared/bloc/update_item_bloc.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';
import 'package:whereisit/shared/widgets/image_source_choice/image_source_choice_popup.dart';
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

  var imageName = '';
  var showImageSourceChoice = false;

  handleAddImage() {
    setState(() {
      showImageSourceChoice = true;
    });
  }

  saveImage(XFile image) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    var path = '${tempDir.path}/${image.name}';
    image.saveTo(path);
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      var routeArgs = args as RouteArguments;
      if (routeArgs.hasParams && routeArgs.params!.containsKey('id')) {
        BlocProvider.of<UpdateItemBloc>(context).add(
          UpdateItemAll(routeArgs.params!['id']!),
        );
      }
      if (routeArgs.hasParams && routeArgs.params!.containsKey('image')) {
        getApplicationDocumentsDirectory().then((tempDir) {
          setState(() {
            imageName = '${tempDir.path}/${routeArgs.params!['image']!}';
          });
        });
      }
    }

    return AppScaffold(
      body: SingleChildScrollViewMod(
        child: BlocBuilder<UpdateItemBloc, UpdateItemState>(
          builder: (context, state) {
            if (state is UpdateItemAllSuccess) {
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

            return Form(
              key: _formKey,
              child: Stack(
                children: [
                  Column(
                    children: [
                      HorizontalImageListContainer(
                        addImage: handleAddImage,
                        images: [imageName],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: "Item name",
                              hintText: "Enter the name of the item"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                  if (showImageSourceChoice)
                    ImageSourceChoicePopup(
                      handler: handleImageSourceSelection,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
