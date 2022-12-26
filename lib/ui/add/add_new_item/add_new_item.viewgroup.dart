import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/pill_tag.dart';

class AddNewItem extends StatelessWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
