import 'package:flutter/material.dart';
import 'package:whereisit/screens/add/add_new_item/add_new_item.viewgroup.dart';

class Add extends StatelessWidget {
  const Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
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
            const AddNewItem(),
          ],
        ),
      ),
    );
  }
}
