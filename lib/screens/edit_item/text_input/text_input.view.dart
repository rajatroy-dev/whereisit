import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final String labelText;
  final String? Function(String?) validator;

  const TextInput({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.initialValue,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.number,
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(10.0),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
