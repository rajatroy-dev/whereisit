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
    // TODO: Handle new address
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<EditItemBloc, EditItemState>(
        builder: (context, state) {
          if (state is EditItemAddressSearchSuccess) {
            var addresses = state.item.uiSearchedAddresses ?? <String>[];
            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
