import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final AppBarAction? action;

  const AppScaffold({
    Key? key,
    this.body,
    this.bottomNavigationBar,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhereIsIt'),
        actions: <Widget>[
          if (action != null && action == AppBarAction.edit)
            IconButton(
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
          if (action != null && action == AppBarAction.search)
            IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
        ],
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
