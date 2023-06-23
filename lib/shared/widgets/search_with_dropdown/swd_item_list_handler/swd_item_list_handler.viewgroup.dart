import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/search_items/bloc/search_items_bloc.dart';

class SwdItemListHandler extends StatefulWidget {
  const SwdItemListHandler({Key? key}) : super(key: key);

  @override
  State<SwdItemListHandler> createState() => _SwdItemListHandlerState();
}

class _SwdItemListHandlerState extends State<SwdItemListHandler> {
  final _controller = TextEditingController();
  var showDropdown = false;

  handleAddToList(String value) {
    setState(() {
      showDropdown = false;
    });
  }

  handleSelect(String value) {
    _controller.text = value;
    setState(() {
      showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<SearchItemsBloc, SearchItemsState>(
          builder: (context, state) {
            if (state is SearchItemsTextFilterSuccess) {
              return SingleChildScrollView(
                // TODO: Dosplay fullwidth card list
                child: const SizedBox(),
              );
            }
            if (state is SearchItemsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text('Something went wrong!'),
            );
          },
        ),
        //   TagDropdownList(
        //     handleNew: handleAddToList,
        //     handleSelect: handleSelect,
        //   ),
        // ],
        // ),
      ),
    );
  }
}
