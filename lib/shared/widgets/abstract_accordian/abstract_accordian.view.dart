import 'package:flutter/material.dart';

abstract class AbstractAccordian extends StatefulWidget {
  final String title;
  final List<String> content;

  const AbstractAccordian({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  AbstractAccordianState createState();
}

abstract class AbstractAccordianState<T extends AbstractAccordian>
    extends State<T> {
  // Show or hide the content
  bool isAccordianOpen = false;

  void handleAccordianTitleTap(BuildContext context);
  void handleAccordianItemTap(BuildContext context, int itemIndex);
  List<Widget> buildAccordianList();
  Widget? buildAccordianTitleTrailingIcon();
  Widget? buildAccordianTitle();

  void toggleAccordian() {
    setState(() {
      isAccordianOpen = !isAccordianOpen;
    });
  }

  @override
  Widget build(BuildContext context);
}
