// https://www.kindacode.com/article/how-to-create-accordions-in-flutter-without-plugins/
// accordion.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/location.model.dart';
import 'package:whereisit/models/property.model.dart';
import 'package:whereisit/screens/filter_options/bloc/filter_options_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/available_filters.enum.dart';
import 'package:whereisit/shared/widgets/accordian/accordian.view.dart';

class FilterAccordian extends StatefulWidget {
  final String title;
  final List<int> content;
  final bool? isOnlyCategory;
  final AvailableFilters filterType;

  const FilterAccordian({
    super.key,
    required this.title,
    required this.content,
    this.isOnlyCategory,
    required this.filterType,
  });

  @override
  State<FilterAccordian> createState() => _FilterAccordianState();
}

class _FilterAccordianState extends State<FilterAccordian> {
  var isAccordianOpen = false;
  var isFirstLoad = true;
  var list = <dynamic>[];

  void handleAccordianItemTap(int itemIndex, bool state) {
    BlocProvider.of<FilterOptionsBloc>(context).add(
      FilterOptionsToggle(widget.filterType, itemIndex, state),
    );
  }

  Widget buildAccordianList(FilterOptionsState state) {
    if (isFirstLoad) {
      return const Center(child: CircularProgressIndicator());
    }

    var columnList = <Widget>[];
    var options = <dynamic>[];
    if (state is FilterOptionsLoadTypeSuccess) {
      switch (widget.filterType) {
        case AvailableFilters.property:
          options = state.filterOptions as List<Property>;
          break;
        case AvailableFilters.location:
          options = state.filterOptions as List<Location>;
          break;
        default:
          break;
      }
    }

    for (var index = 0; index < widget.content.length; index++) {
      var text = '';

      switch (widget.filterType) {
        case AvailableFilters.property:
          var tProperty = options[index] as Property;
          text = tProperty.name;
          break;
        case AvailableFilters.location:
          var tLocation = options[index] as Location;
          text = tLocation.address;
          break;
        default:
          break;
      }

      columnList.add(
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) => handleAccordianItemTap(
                index,
                value ?? false,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 16.0,
                bottom: 8.0,
                left: 32.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(text),
              ),
            ),
          ],
        ),
      );
    }

    return Column(children: columnList);
  }

  void handleAccordianTitleTap(BuildContext context) {
    isFirstLoad = false;
    BlocProvider.of<EditItemBloc>(context).add(
      EditItemSubcategorySelect({widget.title: widget.content[itemIndex]}),
    );

    switch (widget.filterType) {
      case AvailableFilters.property:
        BlocProvider.of<FilterOptionsBloc>(context).add(
          FilterOptionsLoadType(widget.filterType, widget.content),
        );
        break;
      case AvailableFilters.category:
        break;
      case AvailableFilters.location:
        break;
      case AvailableFilters.room:
        break;
      case AvailableFilters.tags:
        break;
      default:
        break;
    }

    toggleAccordian();
  }

  Widget? buildAccordianTitle() {
    return Text(widget.title);
  }

  Widget? buildAccordianTitleTrailingIcon() {
    return Icon(
      isAccordianOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
    );
  }

  void toggleAccordian() {
    setState(() {
      isAccordianOpen = !isAccordianOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterOptionsBloc, FilterOptionsState>(
      builder: (context, state) {
        return Accordian(
          buildAccordianList: () => buildAccordianList(state),
          buildAccordianTitle: buildAccordianTitle,
          buildAccordianTitleTrailingIcon: buildAccordianTitleTrailingIcon,
          handleAccordianTitleTap: handleAccordianTitleTap,
          isAccordianOpen: isAccordianOpen,
        );
      },
    );
  }
}
