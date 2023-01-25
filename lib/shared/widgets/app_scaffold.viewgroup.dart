import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    Key? key,
    this.body,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhereIsIt'),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
