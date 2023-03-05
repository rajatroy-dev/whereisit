import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';

class AppScaffold extends StatefulWidget {
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
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.action != null && widget.action == AppBarAction.search
            ? TextField(
                controller: textController,
                onChanged: (value) {},
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
            widget.action != null && widget.action == AppBarAction.search
                ? false
                : true,
        centerTitle:
            widget.action != null && widget.action == AppBarAction.search
                ? true
                : null,
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
          if (widget.action != null && widget.action == AppBarAction.search)
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
        ],
      ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
