// https://www.kindacode.com/article/how-to-create-accordions-in-flutter-without-plugins/
// accordion.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void handleAccordianItemTap(BuildContext context, int itemIndex) {
    BlocProvider.of<EditItemBloc>(context).add(
      EditItemSubcategorySelect({widget.title: widget.content[itemIndex]}),
    );
  }

  Widget buildAccordianList() {
    if (isFirstLoad) {
      return const Center(child: CircularProgressIndicator());
    }

    var columnList = <Widget>[];
    for (var index = 0; index < widget.content.length; index++) {
      columnList.add(
        InkWell(
          onTap: () => handleAccordianItemTap(context, index),
          child: Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
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
                  child: Text(widget.content[index]),
                ),
              ),
            ],
          ),
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
          FilterOptionsLoadProperties(widget.content),
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
    return Accordian(
      buildAccordianList: buildAccordianList,
      buildAccordianTitle: buildAccordianTitle,
      buildAccordianTitleTrailingIcon: buildAccordianTitleTrailingIcon,
      handleAccordianTitleTap: handleAccordianTitleTap,
      isAccordianOpen: isAccordianOpen,
    );
  }
}
