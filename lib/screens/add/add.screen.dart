import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/shared/widgets/edit_item/edit_item.viewgroup.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  var showImageSourceChoice = false;

  handleAddImage() {
    setState(() {
      showImageSourceChoice = true;
    });
  }

  handleImageSourceSelection(BuildContext context, SourceChoice choice) async {
    ImagePicker picker = ImagePicker();

    switch (choice) {
      case SourceChoice.gallery:
        var image = await picker.pickImage(source: ImageSource.gallery);
        Navigator.pushNamed(
          context,
          EditItem.routeName,
          arguments: image,
        );
        break;
      case SourceChoice.camera:
        var image = await picker.pickImage(source: ImageSource.camera);
        Navigator.pushNamed(
          context,
          EditItem.routeName,
          arguments: image,
        );
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
    return Center(
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
            const EditItem(),
          ],
        ),
      ),
    );
  }
}
