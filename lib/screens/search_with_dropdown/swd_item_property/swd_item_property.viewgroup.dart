import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

// Stateful widget renders ListView efficiently
class SwdItemProperty extends StatefulWidget {
  const SwdItemProperty({Key? key}) : super(key: key);

  @override
  State<SwdItemProperty> createState() => _SwdItemPropertyState();
}

class _SwdItemPropertyState extends State<SwdItemProperty> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<EditItemBloc, EditItemState>(
        builder: (context, state) {
          if (state is EditItemPropertyLoadSuccess ||
              state is EditItemPropertySearchSuccess) {
            var properties = state.item.uiSearchedProperties ?? <String>[];
            var newProperty = state.item.uiProperty ?? '';

            if (properties.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<EditItemBloc>(context).add(
                      EditItemPropertySelect(newProperty),
                    );
                  },
                  child: Text(newProperty),
                ),
              );
            }

            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      BlocProvider.of<EditItemBloc>(context).add(
                        EditItemPropertySelect(addresses[index]),
                      );
                    },
                    child: Text(addresses[index]),
                  ),
                );
              },
            );
          }
          return const Text("No properties to display!");
        },
      ),
    );
  }
}
