import 'package:flutter/material.dart';

class Accordian extends StatelessWidget {
  final bool isAccordianOpen;

  final void Function(BuildContext context) handleAccordianTitleTap;
  final List<Widget> Function() buildAccordianList;
  final Widget? Function() buildAccordianTitleTrailingIcon;
  final Widget? Function() buildAccordianTitle;

  const Accordian({
    super.key,
    required this.isAccordianOpen,
    required this.handleAccordianTitleTap,
    required this.buildAccordianList,
    required this.buildAccordianTitleTrailingIcon,
    required this.buildAccordianTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => handleAccordianTitleTap(context),
            child: ListTile(
              // The title
              title: buildAccordianTitle(),
              trailing: buildAccordianTitleTrailingIcon(),
            ),
          ),
          // Show or hide the content based on the state
          if (isAccordianOpen)
            Column(
              children: buildAccordianList(),
            ),
        ],
      ),
    );
  }
}
