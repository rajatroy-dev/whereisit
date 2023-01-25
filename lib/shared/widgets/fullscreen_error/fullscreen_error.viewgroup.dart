import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';

class FullScreenError extends StatelessWidget {
  final String errorMessage;

  const FullScreenError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_rounded,
                  size: 32.0,
                  color: Colors.red[900],
                ),
                Text(
                  'ERROR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.red[900],
                  ),
                ),
                const SizedBox(height: 24),
                Text(errorMessage),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
