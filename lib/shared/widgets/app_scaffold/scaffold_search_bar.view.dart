import 'package:flutter/material.dart';

class ScaffoldSearchBar extends StatelessWidget {
  final void Function()? handleClear;
  final String? searchHint;
  final TextEditingController? controller;

  const ScaffoldSearchBar({
    Key? key,
    this.controller,
    required this.handleClear,
    this.searchHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: searchHint,
            hintStyle: const TextStyle(
              fontSize: 18,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: handleClear,
            ),
          ),
        ),
      ),
    );
  }
}
