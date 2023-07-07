import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class SwdItemAddress extends StatefulWidget {
  const SwdItemAddress({Key? key}) : super(key: key);

  @override
  State<SwdItemAddress> createState() => _SwdItemAddressState();
}

class _SwdItemAddressState extends State<SwdItemAddress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<EditItemBloc, EditItemState>(
        builder: (context, state) {
          if (state is EditItemAddressLoadSuccess ||
              state is EditItemAddressSearchSuccess) {
            var addresses = state.item.uiSearchedAddresses ?? <String>[];
            var newAddress = state.item.uiAddress ?? '';

            if (addresses.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<EditItemBloc>(context).add(
                      EditItemAddressSelect(newAddress),
                    );
                  },
                  child: Text(newAddress),
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
                        EditItemAddressSelect(addresses[index]),
                      );
                    },
                    child: Text(addresses[index]),
                  ),
                );
              },
            );
          }
          return const Text("No addresses to display!");
        },
      ),
    );
  }
}