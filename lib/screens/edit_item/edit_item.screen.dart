import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereisit/screens/edit_item/edit_item_form/edit_item_form.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/image_source_choice/image_source_choice_popup.dart';
import 'package:whereisit/shared/widgets/single_child_scroll_view_mod/single_child_scroll_view_mod.viewgroup.dart';

class EditItem extends StatefulWidget {
  static const routeName = '/edit-item';

  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  var imageList = <String>[];
  var showImageSourceChoice = false;
  var coordinates = '';

  @override
  void initState() {
    super.initState();
  }

  handleAddImage() {
    setState(() {
      showImageSourceChoice = true;
    });
  }

  saveImage(XFile image) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    var path = '${tempDir.path}/${image.name}';
    await image.saveTo(path);
    BlocProvider.of<EditItemBloc>(context).add(EditItemImageAdd(path));
    setState(() {
      showImageSourceChoice = false;
    });
  }

  handleImageSourceSelection(SourceChoice choice) async {
    ImagePicker picker = ImagePicker();

    switch (choice) {
      case SourceChoice.gallery:
        var image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) await saveImage(image);
        break;
      case SourceChoice.camera:
        var image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) await saveImage(image);
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

    if (args != null && args is RouteArguments) {
      if (args.hasParams &&
          args.params != null &&
          args.params!.containsKey('id')) {
        BlocProvider.of<EditItemBloc>(context).add(
          EditItemExisting(int.parse(args.params!['id']!)),
        );
      }
      if (args.hasParams &&
          args.params != null &&
          args.params!.containsKey('image') &&
          imageList.isEmpty) {
        var temp = imageList;
        getApplicationDocumentsDirectory().then((tempDir) {
          temp.add('${tempDir.path}/${args.params!['image']!}');
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
            child: EditItemForm(
              imageSourceChoiceHandler: handleAddImage,
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
