import 'package:flutter/material.dart';

class PillTag extends StatelessWidget {
  final String title;
  final bool isShort;
  final bool hasDelete;
  final void Function()? handleDelete;

  const PillTag({
    Key? key,
    required this.title,
    this.isShort = true,
    this.hasDelete = false,
    this.handleDelete,
  })  : assert(
          (hasDelete && handleDelete != null) ||
              (!hasDelete && handleDelete == null),
          'Delete option for PillTag was enabled but function was not provided!',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 8.0,
            ),
            child: ConstrainedBox(
              constraints: isShort
                  ? const BoxConstraints(
                      maxWidth: 60,
                    )
                  : const BoxConstraints(
                      maxWidth: 200,
                    ),
              child: Text(
                title,
                style: isShort
                    ? const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
              ),
            ),
          ),
          if (hasDelete)
            GestureDetector(
              onTap: handleDelete,
              child: IntrinsicHeight(
                child: Row(
                  children: const [
                    VerticalDivider(
                      width: 0,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
