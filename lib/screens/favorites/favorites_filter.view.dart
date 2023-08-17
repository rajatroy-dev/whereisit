import 'package:flutter/material.dart';

class FavoritesFilter extends StatelessWidget {
  const FavoritesFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.filter_alt_rounded,
      ),
      onPressed: () {
        // TODO: Add Bloc to handle filter
      },
    );
  }
}
