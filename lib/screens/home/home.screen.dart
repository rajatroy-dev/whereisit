import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/home/cubit/home_cubit.dart';
import 'package:whereisit/screens/home/items_list/items_list.viewgroup.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_container.viewgroup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TilesContainer(),
        ItemsList(),
      ],
    );
  }
}
