import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/location_search/location_search.screen.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';

class AppScaffold extends StatefulWidget {
  final AppBarAction? action;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool? hasSearch;

  const AppScaffold({
    Key? key,
    this.action,
    this.body,
    this.bottomNavigationBar,
    this.hasSearch,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    textController.addListener(
      () => LocationSearchByKeyword(textController.text),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.hasSearch != null && widget.hasSearch!
            ? TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Search location . . .',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text('WhereIsIt'),
        automaticallyImplyLeading:
            widget.hasSearch != null && widget.hasSearch! ? false : true,
        centerTitle:
            widget.hasSearch != null && widget.hasSearch! ? true : null,
        actions: <Widget>[
          if (widget.action != null && widget.action == AppBarAction.edit)
            IconButton(
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
          if (widget.action != null && widget.action == AppBarAction.goToSearch)
            IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                LocationSearchScreen.routeName,
              ).then((value) => LocationSelected(value as String)),
            ),
          if (widget.action != null && widget.action == AppBarAction.clear)
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
              onPressed: () => BlocProvider.of<LocationSearchBloc>(context).add(
                LocationSearchClear(),
              ),
            ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
