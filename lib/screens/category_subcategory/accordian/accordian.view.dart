// https://www.kindacode.com/article/how-to-create-accordions-in-flutter-without-plugins/
// accordion.dart
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // Show or hide the content
  bool _showContent = false;

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
              title: Text(widget.title),
              trailing: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ),
          ),
          // Show or hide the content based on the state
          _showContent
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(widget.content),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
