import 'package:flutter/material.dart';

class FullScreenError extends StatelessWidget {
  final String errorMessage;

  const FullScreenError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          children: [
            const Icon(
              Icons.error_rounded,
              size: 32.0,
            ),
            const Text(
              'ERROR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            Text(errorMessage),
          ],
        ),
      ),
    );
  }
}
