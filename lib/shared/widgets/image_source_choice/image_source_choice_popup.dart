import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/source_choice.enum.dart';
import 'package:whereisit/shared/widgets/image_source_choice/each_choice.dart';

class ImageSourceChoicePopup extends StatelessWidget {
  final void Function(SourceChoice) handler;

  const ImageSourceChoicePopup({
    Key? key,
    required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EachChoice(
                      btnTxt: "Gallery",
                      choice: SourceChoice.gallery,
                      handler: handler,
                    ),
                    EachChoice(
                      btnTxt: "Camera",
                      choice: SourceChoice.camera,
                      handler: handler,
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => handler(SourceChoice.none),
                      child: const Text("Cancel"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
