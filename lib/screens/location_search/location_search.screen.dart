import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/location_search/location_search_bloc.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class LocationSearchScreen extends StatefulWidget {
  static const routeName = '/location-search';

  const LocationSearchScreen({Key? key}) : super(key: key);

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasSearch: true,
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
                return Flexible(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(
                      context,
                      'address=alsdalksd&coordinates=12.12,123.123',
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      width: double.infinity,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        child: Text(state.locationList[index]),
                      ),
                    ),
                  ),
                );
              }),
            );
          }
          return const Center(
            child: Text('Oops! Something went wrong!'),
          );
        },
      ),
    );
  }
}
