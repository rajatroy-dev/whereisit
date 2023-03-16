import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/screens/filtered_items/bloc/filtered_items_bloc.dart';
import 'package:whereisit/shared/enums/chronology.enum.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';
import 'package:whereisit/shared/intents/view_all.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card_list.viewgroup.dart';
import 'package:whereisit/shared/widgets/fullscreen_error/fullscreen_error.viewgroup.dart';
import 'package:whereisit/shared/widgets/sort/item_sort.viewgroup.dart';
import 'package:whereisit/shared/widgets/sort_filter/sort_filter.viewgroup.dart';

class FilteredItems extends StatefulWidget {
  static const routeName = '/filtered-items';

  const FilteredItems({Key? key}) : super(key: key);

  @override
  State<FilteredItems> createState() => _FilteredItemsState();
}

class _FilteredItemsState extends State<FilteredItems> {
  var showSortBy = false;

  handleSortToggle() {
    setState(() {
      showSortBy = !showSortBy;
    });
  }

  handleSortChange(Chronology? chronology) {
    BlocProvider.of<FilteredItemsBloc>(context).add(
      FilteredItemsSort(chronology!),
    );

    setState(() {
      showSortBy = !showSortBy;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    var intent = ViewAllIntent(
      isSuccess: false,
      traits: Traits.none,
    );

    if (null != args && args is Traits) {
      intent = ViewAllIntent(
        isSuccess: true,
        traits: args,
      );
      BlocProvider.of<FilteredItemsBloc>(context).add(
        FilteredItemsBy(intent.traits),
      );
    }

    if (!intent.isSuccess!) {
      return const AppScaffold(
        body: FullScreenError(errorMessage: 'Something Went Wrong!'),
      );
    }

    return AppScaffold(
      body: BlocBuilder<FilteredItemsBloc, FilteredItemsState>(
        builder: (context, state) {
          if (state is FilteredItemsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FilteredItemsSuccess) {
            return Stack(
              children: [
                Column(
                  children: [
                    SortFilter(
                      sortHandler: handleSortToggle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 5.0,
                      ),
                      child: TextFormField(
                        onChanged: (value) =>
                            BlocProvider.of<FilteredItemsBloc>(context).add(
                          FilteredItemsSearch(value),
                        ),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Search . . .',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FullWidthCardList(
                        list: state.filteredItems['data'] as List<CardData>,
                      ),
                    ),
                  ],
                ),
                if (showSortBy)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ItemSort(
                      chronology: state.filteredItems['sort'],
                      handleChange: handleSortChange,
                    ),
                  ),
              ],
            );
          } else if (state is FilteredItemsFailure) {
            return FullScreenError(errorMessage: state.errorMessage);
          }

          return const AppScaffold(body: SizedBox());
        },
      ),
    );
  }
}
