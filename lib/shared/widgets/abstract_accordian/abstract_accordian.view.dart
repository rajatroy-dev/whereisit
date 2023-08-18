import 'package:flutter/material.dart';

abstract class AbstractAccordian extends StatelessWidget {
  final String title;
  final List<String> content;

  const AbstractAccordian({
    super.key,
    required this.title,
    required this.content,
  });

  void handleAccordianItemTap(BuildContext context);

  List<Widget> buildAccordianList();
}
