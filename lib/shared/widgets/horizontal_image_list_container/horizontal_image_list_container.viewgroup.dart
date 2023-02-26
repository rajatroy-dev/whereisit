import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontail_list_image/horizontal_list_image.viewgroup.dart';

class HorizontalImageListContainer extends StatelessWidget {
  final List<String> images;
  final void Function() addImage;

  const HorizontalImageListContainer({
    Key? key,
    required this.addImage,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Item Image(s)'),
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return HorizontalListImage(image: images[index]);
              },
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: addImage,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add more'),
        ),
      ],
    );
  }
}
