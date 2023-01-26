import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/filtered_items/bloc/filtered_items_bloc.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';
import 'package:whereisit/shared/intents/view_all.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card_list.viewgroup.dart';
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
    );

    if (null != args) {
      intent = ViewAllIntent(
        isSuccess: true,
        traits: args as Traits,
      );
      BlocProvider.of<FilteredItemsBloc>(context).add(
        FilteredItemsBy(intent.traits),
      );
    }

    if (!intent.isSuccess!) {
      return const FullScreenError(errorMessage: 'Something Went Wrong!');
    }

    return BlocBuilder<FilteredItemsBloc, FilteredItemsState>(
      builder: (context, state) {
        if (state is FilteredItemsLoading) {
          return const AppScaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is FilteredItemsSuccess) {
          return AppScaffold(
            body: FullWidthCardList(list: state.filteredItems),
          );
        } else if (state is FilteredItemsFailure) {
          return FullScreenError(errorMessage: state.errorMessage);
        }

        return const AppScaffold(body: SizedBox());
      },
    );
  }
}
