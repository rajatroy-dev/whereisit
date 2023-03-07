import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whereisit/screens/filtered_items/bloc/filtered_items_bloc.dart';
import 'package:whereisit/screens/filtered_items/filtered_items.screen.dart';
import 'package:whereisit/screens/home/cubit/home_cubit.dart';
import 'package:whereisit/screens/home/home.screen.dart';
import 'package:whereisit/screens/item_details/item_details.screen.dart';
import 'package:whereisit/screens/screens/add.dart';
import 'package:whereisit/screens/screens/all_items.dart';
import 'package:whereisit/screens/screens/favorites.dart';
import 'package:whereisit/screens/screens/search.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/bloc/update_item/update_item_bloc.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/bottom_nav_bar/bottom_nav_bar.view.dart';
import 'package:whereisit/screens/edit_item/edit_item.viewgroup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => FilteredItemsBloc()),
        BlocProvider(create: (context) => UpdateItemBloc()),
        BlocProvider(create: (context) => LocationSearchBloc()),
      ],
      child: MaterialApp(
        title: 'WhereIsIt',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          FilteredItems.routeName: (context) => const FilteredItems(),
          ItemDetails.routeName: (context) => const ItemDetails(),
          EditItem.routeName: (context) => const EditItem(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
    return AppScaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
