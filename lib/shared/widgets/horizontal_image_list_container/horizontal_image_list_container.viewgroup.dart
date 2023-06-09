import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontail_list_image/horizontal_list_image.viewgroup.dart';

class HorizontalImageListContainer extends StatelessWidget {
  final List<String> images;
  final bool isDeletable;

  const HorizontalImageListContainer({
    Key? key,
    required this.images,
    this.isDeletable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.purple),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            height: 150,
            width: 150,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.camera_alt_rounded),
                  Text('No image selected!'),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return HorizontalListImage(
                  image: images[index],
                  isDeletable: isDeletable,
                );
              },
            ),
          );
  }
}
