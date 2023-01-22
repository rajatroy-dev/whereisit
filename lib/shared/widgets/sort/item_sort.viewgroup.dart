import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/chronology.enum.dart';

class ItemSort extends StatefulWidget {
  const ItemSort({Key? key}) : super(key: key);

  @override
  State<ItemSort> createState() => _ItemSortState();
}

class _ItemSortState extends State<ItemSort> {
  // ignore: prefer_final_fields
  Chronology? _chronology = Chronology.newestFirst;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Lafayette'),
            leading: Radio<Chronology>(
              value: Chronology.oldestFirst,
              groupValue: _chronology,
              onChanged: (Chronology? value) {},
            ),
          ),
          ListTile(
            title: const Text('Thomas Jefferson'),
            leading: Radio<Chronology>(
              value: Chronology.newestFirst,
              groupValue: _chronology,
              onChanged: (Chronology? value) {},
            ),
          ),
        ],
      ),
    );
  }
}
