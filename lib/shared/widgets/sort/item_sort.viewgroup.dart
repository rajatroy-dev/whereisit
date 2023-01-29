import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/chronology.enum.dart';

class ItemSort extends StatelessWidget {
  final Chronology? chronology;
  final void Function(Chronology?)? handleChange;

  const ItemSort({
    Key? key,
    this.chronology,
    this.handleChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Not sorted'),
            leading: Radio<Chronology>(
              value: Chronology.none,
              groupValue: chronology,
              onChanged: handleChange,
            ),
          ),
          ListTile(
            title: const Text('Oldest'),
            leading: Radio<Chronology>(
              value: Chronology.oldestFirst,
              groupValue: chronology,
              onChanged: handleChange,
            ),
          ),
          ListTile(
            title: const Text('Newest'),
            leading: Radio<Chronology>(
              value: Chronology.newestFirst,
              groupValue: chronology,
              onChanged: handleChange,
            ),
          ),
        ],
      ),
    );
  }
}
