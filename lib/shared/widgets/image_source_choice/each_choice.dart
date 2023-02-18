import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';

class EachChoice extends StatelessWidget {
  final String btnTxt;
  final SourceChoice choice;
  final void Function(SourceChoice) handler;

  const EachChoice({
    Key? key,
    required this.btnTxt,
    required this.handler,
    required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 122,
      child: Padding(
        padding: choice == SourceChoice.gallery
            ? const EdgeInsets.only(left: 50.0, top: 10.0)
            : const EdgeInsets.only(right: 50.0, top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 80,
              onPressed: () => handler(choice),
              icon: choice == SourceChoice.gallery
                  ? const Icon(Icons.insert_photo_rounded)
                  : const Icon(Icons.camera_alt_rounded),
            ),
            Text(btnTxt),
          ],
        ),
      ),
    );
  }
}
