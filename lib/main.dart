import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/item.model.dart';
import 'package:whereisit/screens/add/add.screen.dart';
import 'package:whereisit/screens/all_items/all_items.screen.dart';
import 'package:whereisit/screens/category_subcategory/category_subcategory.viewgroup.dart';
import 'package:whereisit/screens/favorites/favorites.screen.dart';
import 'package:whereisit/screens/favorites/favorites_filter.view.dart';
import 'package:whereisit/screens/filtered_items/bloc/filtered_items_bloc.dart';
import 'package:whereisit/screens/filtered_items/filtered_items.screen.dart';
import 'package:whereisit/screens/home/bloc/home_bloc.dart';
import 'package:whereisit/screens/home/home.screen.dart';
import 'package:whereisit/screens/item_details/item_details.screen.dart';
import 'package:whereisit/screens/search_items/search_items.screen.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';
import 'package:whereisit/screens/view_item/view_item.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/bottom_nav_bar/bottom_nav_bar.view.dart';
import 'package:whereisit/screens/edit_item/edit_item.screen.dart';
import 'package:whereisit/screens/map_location_selector/map_location_selector.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => FilteredItemsBloc()),
        BlocProvider(
          create: (context) => EditItemBloc(Item.forUi({})),
        ),
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
          ViewItemScreen.routeName: (context) => ViewItemScreen(),
          MapLocationSelector.routeName: (context) =>
              const MapLocationSelector(),
          SearchItemsScreen.routeName: (context) => const SearchItemsScreen(),
          CategorySubcategoryScreen.routeName: (context) =>
              const CategorySubcategoryScreen(),
          SearchWithDropdownScreen.routeName: (context) =>
              const SearchWithDropdownScreen(),
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
    SearchItemsScreen(key: ValueKey('Search Screen')),
    AllItemsScreen(key: ValueKey('All Items Screen')),
    AddScreen(key: ValueKey('Add Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: _screens.elementAt(_selectedIndex) is SearchItemsScreen
          ? AppBarAction.searchItem
          : null,
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton:
          _selectedIndex == 1 ? const FavoritesFilter() : null,
    );
  }
}
