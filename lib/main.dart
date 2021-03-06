import 'package:flutter/material.dart';

import 'ui/screens/add.dart';
import 'ui/screens/all_items.dart';
import 'ui/screens/favorites.dart';
import 'ui/screens/home.dart';
import 'ui/screens/search.dart';
import 'ui/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhereIsIt',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'WhereIsIt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _screens = <Widget>[
    HomeScreen(key: ValueKey('Home Screen')),
    FavoritesScreen(key: ValueKey('Favorites Screen')),
    SearchScreen(key: ValueKey('Search Screen')),
    AllItemsScreen(key: ValueKey('All Items Screen')),
    AddScreen(key: ValueKey('Add Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
