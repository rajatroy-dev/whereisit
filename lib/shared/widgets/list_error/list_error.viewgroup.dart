import 'package:flutter/material.dart';

class ListError extends StatelessWidget {
  final String errorMessage;

  const ListError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 14.0,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red[900]!),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.red[50],
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.red[900]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error_rounded, color: Colors.red[900]),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'ERROR: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Flexible(
              child: Text(
                errorMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
