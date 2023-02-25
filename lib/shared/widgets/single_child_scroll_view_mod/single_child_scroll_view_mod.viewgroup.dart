import 'package:flutter/material.dart';

// https://github.com/flutter/flutter/issues/18711#issuecomment-505791677
class SingleChildScrollViewMod extends StatelessWidget {
  final Widget? child;

  const SingleChildScrollViewMod({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
