import 'package:flutter/material.dart';

class SortFilter extends StatelessWidget {
  const SortFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.purple,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sort_rounded),
                label: const Text('Sort'),
              ),
            ),
            const VerticalDivider(
              color: Colors.purple,
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_rounded),
                label: const Text('Filter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
