import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Filter By"),
        const Text("Property"),
        const Text("Area"),
        const Text("Room"),
        const Text("Favorite"),
        Row(
          children: [
            const Text("Yes"),
            Checkbox(
              value: true,
              onChanged: (bool? value) {},
            ),
            const Text("No"),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
        const Text("Tags"),
        Row(
          children: [
            const Text("#abc"),
            Checkbox(
              value: true,
              onChanged: (bool? value) {},
            ),
            const Text("#def"),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
            const Text("#ghi"),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
            const Text("#jkl"),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
        const Text("Map Location"),
      ],
    );
  }
}
