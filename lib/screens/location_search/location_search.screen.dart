import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({Key? key}) : super(key: key);

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      action: AppBarAction.search,
      body: BlocBuilder<LocationSearchBloc, LocationSearchState>(
        builder: (context, state) {
          if (state is LocationSearchFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is LocationSearchSuccess) {
            return ListView.builder(
              itemCount: state.locationList.length,
              itemBuilder: ((context, index) {
                return Text(state.locationList[index]);
              }),
            );
          }
          return const Center(
            child: Text('Oops! Something went wrong!'),
          );
        },
      ),
    );
    ;
  }
}
