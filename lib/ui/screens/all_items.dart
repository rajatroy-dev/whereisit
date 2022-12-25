import 'package:flutter/material.dart';
import 'package:whereisit/ui/all_items/all_items.screen.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AllItems(),
    );
  }
}
