// https://www.kindacode.com/article/how-to-create-accordions-in-flutter-without-plugins/
// accordion.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class Accordion extends StatefulWidget {
  final String title;
  final List<String> content;
  final bool? isEditable;

  const Accordion({
    Key? key,
    required this.title,
    required this.content,
    this.isEditable,
  }) : super(key: key);
  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // Show or hide the content
  bool _showContent = false;

  List<Widget> _buildList(String category) {
    var columnList = <Widget>[];
    for (var element in widget.content) {
      columnList.add(
        InkWell(
          onTap: () => BlocProvider.of<EditItemBloc>(context).add(
            EditItemSubcategorySelect({category: element}),
          ),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: widget.isEditable != null && widget.isEditable!
                ? TextFormField(initialValue: element)
                : Text(element),
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
            onTap: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
            child: ListTile(
              title: widget.isEditable != null && widget.isEditable!
                  ? TextFormField(initialValue: widget.title)
                  : Text(widget.title),
              trailing: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
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
