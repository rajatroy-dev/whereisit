import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontail_list_image/horizontal_list_image.viewgroup.dart';

class HorizontalImageListContainer extends StatefulWidget {
  const HorizontalImageListContainer({Key? key}) : super(key: key);

  @override
  State<HorizontalImageListContainer> createState() =>
      _HorizontalImageListContainerState();
}

class _HorizontalImageListContainerState
    extends State<HorizontalImageListContainer> {
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

  handleImageSourceSelection(BuildContext context, SourceChoice choice) async {
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
    return Column(
      children: [
        const Text('Item Image(s)'),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const HorizontalListImage();
            },
          ),
        ),
        ElevatedButton.icon(
          onPressed: handleAddImage,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add more'),
        ),
      ],
    );
  }
}
