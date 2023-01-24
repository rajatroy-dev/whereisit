import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/filtered_items/bloc/filtered_items_bloc.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';
import 'package:whereisit/shared/intents/view_all.intent.dart';
import 'package:whereisit/shared/widgets/fullscreen_error/fullscreen_error.viewgroup.dart';

class FilteredItems extends StatefulWidget {
  static const routeName = '/filtered-items';

  const FilteredItems({Key? key}) : super(key: key);

  @override
  State<FilteredItems> createState() => _FilteredItemsState();
}

class _FilteredItemsState extends State<FilteredItems> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    var intent = ViewAllIntent(
      isSuccess: false,
      traits: Traits.none,
      value: '',
    );

    if (null != args) {
      intent = args as ViewAllIntent;
      intent.isSuccess = true;
      BlocProvider.of<FilteredItemsBloc>(context).add(
        FilteredItemsBy(intent.traits),
      );
    }

    if (!intent.isSuccess!) {
      return const FullScreenError(errorMessage: 'Something Went Wrong!');
    }

    return Container();
  }
}
