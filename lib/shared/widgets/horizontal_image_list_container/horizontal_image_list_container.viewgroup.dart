import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontail_list_image/horizontal_list_image.viewgroup.dart';

class HorizontalImageListContainer extends StatelessWidget {
  final List<String> images;

  const HorizontalImageListContainer({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return HorizontalListImage(image: images[index]);
        },
      ),
    );
  }
}
