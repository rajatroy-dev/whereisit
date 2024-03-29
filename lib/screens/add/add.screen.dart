import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/screens/edit_item/edit_item.screen.dart';
import 'package:whereisit/shared/widgets/image_source_choice/image_source_choice_popup.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var showImageSourceChoice = false;

  handleAddImage() {
    setState(() {
      showImageSourceChoice = true;
    });
  }

  sendImagetoEdit(XFile image) async {
    if (!mounted) return;

    Directory tempDir = await getApplicationDocumentsDirectory();
    var path = '${tempDir.path}/${image.name}';
    await image.saveTo(path);
    if (mounted) {
      BlocProvider.of<EditItemBloc>(context).add(EditItemNewFirstImage(path));
      Navigator.pushNamed(
        context,
        EditItem.routeName,
      );
      setState(() {
        showImageSourceChoice = false;
      });
    }
  }

  handleImageSourceSelection(BuildContext context, SourceChoice choice) async {
    ImagePicker picker = ImagePicker();

    switch (choice) {
      case SourceChoice.gallery:
        var image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          await sendImagetoEdit(image);
        }
        break;
      case SourceChoice.camera:
        var image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          await sendImagetoEdit(image);
        }
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
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: handleAddImage,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add Item'),
                ),
                const Text(
                  '— OR —',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black26,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.luggage_rounded),
                  label: const Text('Add Items'),
                ),
                // const EditItem(),
              ],
            ),
          ),
        ),
        if (showImageSourceChoice)
          ImageSourceChoicePopup(
            handler: (SourceChoice choice) => handleImageSourceSelection(
              context,
              choice,
            ),
          ),
      ],
    );
  }
}
