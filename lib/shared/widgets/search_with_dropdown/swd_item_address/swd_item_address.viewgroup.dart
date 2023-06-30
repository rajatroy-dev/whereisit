import 'package:flutter/material.dart';

class SwdItemAddress extends StatefulWidget {
  const SwdItemAddress({Key? key}) : super(key: key);

  @override
  State<SwdItemAddress> createState() => _SwdItemAddressState();
}

class _SwdItemAddressState extends State<SwdItemAddress> {
  final _controller = TextEditingController();
  var showDropdown = false;

  handleAddToList(String value) {
    setState(() {
      showDropdown = false;
    });
  }

  handleSelect(String value) {
    _controller.text = value;
    setState(() {
      showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: SizedBox(),
          );
        },
      ),
    );
  }
}
