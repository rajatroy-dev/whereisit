// https://www.kindacode.com/article/how-to-create-accordions-in-flutter-without-plugins/
// accordion.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class Accordion extends StatefulWidget {
  final String title;
  final List<String> content;
  final bool? isEditable;
  final bool? isOnlyCategory;

  const Accordion({
    Key? key,
    required this.title,
    required this.content,
    this.isEditable,
    this.isOnlyCategory,
  }) : super(key: key);
  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // Show or hide the content
  bool _showContent = false;

  List<Widget> _buildList(String category) {
    var columnList = <Widget>[];
    for (var index = 0; index < widget.content.length; index++) {
      columnList.add(
        InkWell(
          onTap: () => BlocProvider.of<EditItemBloc>(context).add(
            EditItemSubcategorySelect({category: widget.content[index]}),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 16.0,
              bottom: 8.0,
              left: 32.0,
            ),
            child: widget.isEditable != null && widget.isEditable!
                ? TextFormField(
                    onChanged: (value) {
                      BlocProvider.of<EditItemBloc>(context).add(
                        EditItemSubcategoryChange({
                          '$index:$category': value,
                        }),
                      );
                    },
                    initialValue: widget.content[index],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Sub category ${index + 1}',
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(widget.content[index]),
                  ),
          ),
        ),
      );
    }

    return columnList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: Column(
        children: [
          // The title
          InkWell(
            onTap: widget.isOnlyCategory == null || !widget.isOnlyCategory!
                ? () {
                    setState(() {
                      _showContent = !_showContent;
                    });
                  }
                : null,
            child: ListTile(
              title: InkWell(
                onTap: widget.isOnlyCategory != null && widget.isOnlyCategory!
                    ? () => BlocProvider.of<EditItemBloc>(context).add(
                          EditItemCategorySelect(widget.title),
                        )
                    : () {},
                child: widget.isEditable != null && widget.isEditable!
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            BlocProvider.of<EditItemBloc>(context).add(
                              EditItemCategoryChange({widget.title: value}),
                            );
                          },
                          initialValue: widget.title,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Category',
                          ),
                        ),
                      )
                    : Text(widget.title),
              ),
              trailing: widget.isOnlyCategory == null || !widget.isOnlyCategory!
                  ? Icon(
                      _showContent
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    )
                  : const SizedBox(),
            ),
          ),
          // Show or hide the content based on the state
          _showContent
              ? Column(
                  children: _buildList(widget.title),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
