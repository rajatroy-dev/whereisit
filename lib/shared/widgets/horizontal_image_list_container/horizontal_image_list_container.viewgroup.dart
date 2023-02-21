import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontail_list_image/horizontal_list_image.viewgroup.dart';

class HorizontalImageListContainer extends StatelessWidget {
  const HorizontalImageListContainer({Key? key}) : super(key: key);

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
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add'),
        ),
      ],
    );
  }
}
