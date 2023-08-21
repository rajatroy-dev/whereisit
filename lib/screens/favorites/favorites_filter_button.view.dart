import 'package:flutter/material.dart';
import 'package:whereisit/screens/filter_options/filter_options.screen.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';

class FavoritesFilterButton extends StatelessWidget {
  const FavoritesFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.filter_alt_rounded,
      ),
      onPressed: () {
        var args = RouteArguments(
          hasParams: true,
          params: {'fromFavorites': true},
        );
        Navigator.pushNamed(context, FilterOptions.routeName, arguments: args);
      },
    );
  }
}
