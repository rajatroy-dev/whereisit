import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/scaffold_search_bar.view.dart';

class AppScaffold extends StatefulWidget {
  final AppBarAction? action;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const AppScaffold({
    Key? key,
    this.action,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
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
    textController.addListener(() {
      if (widget.action == AppBarAction.searchTag) {
        BlocProvider.of<EditItemBloc>(context).add(
          EditItemTagSearch(textController.text),
        );
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    textController.dispose();
    super.dispose();
  }

  _buildTitle() {
    if (widget.action != null && widget.action == AppBarAction.searchTag) {
      return ScaffoldSearchBar(
        handleClear: () => textController.clear(),
        searchHint: 'Search or add tags',
        controller: textController,
      );
    } else {
      return const Text('WhereIsIt');
    }
  }

  List<Widget> _actionsForCategoryScreen() {
    return [
      IconButton(
        icon: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemCategoryNew(),
          );
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.edit_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemCategoryUpdateInitial(),
          );
          Navigator.pushReplacementNamed(
            context,
            CategorySubcategoryScreen.routeName,
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
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
          if (widget.action != null && widget.action == AppBarAction.searchTag)
            IconButton(
              icon: const Icon(
                Icons.check_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                BlocProvider.of<EditItemBloc>(context).add(
                  EditItemTagsSelected(),
                );
                Navigator.pop(context);
              },
            ),
          if (widget.action != null &&
              widget.action == AppBarAction.addCategory)
            ..._actionsForCategoryScreen(),
          if (widget.action != null &&
              widget.action == AppBarAction.editCategory)
            IconButton(
              icon: const Icon(
                Icons.check_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                BlocProvider.of<EditItemBloc>(context).add(
                  EditItemCategoryUpdate(),
                );
              },
            ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
