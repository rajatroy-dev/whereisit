import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/edit_item/edit_item.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/methods/build_tags_list.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';

class ViewItemScreen extends StatelessWidget {
  static const routeName = '/view-item';

  ViewItemScreen({Key? key}) : super(key: key);

  final _sm = SharedMethods();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null &&
        args is RouteArguments &&
        args.hasParams &&
        args.params != null &&
        args.params!.containsKey('id')) {
      BlocProvider.of<EditItemBloc>(context).add(EditItemLoadExisting(
        int.parse(args.params!['id']!),
      ));
    }

    return AppScaffold(
      body: args != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<EditItemBloc, EditItemState>(
                  builder: (context, state) {
                    if (state is EditItemLoadExistingSuccess) {
                      var imagesList = state.item.uiImagesList ?? [];
                      String coordinates = '';
                      if (state.item.uiCoordinates != null) {
                        coordinates =
                            '${state.item.uiCoordinates!.latitude.toStringAsFixed(2)}, '
                            '${state.item.uiCoordinates!.longitude.toStringAsFixed(2)}';
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HorizontalImageListContainer(
                            images: imagesList,
                            isDeletable: false,
                          ),
                          state.item.quantity != null
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(state.item.quantity.toString()),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(state.item.name),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              state.item.name,
                            ), // TODO: Change after adding field for address
                          ),
                          if (coordinates.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(coordinates),
                            ),
                          if (state.item.uiSelectedCategory != null)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(state.item.uiSelectedCategory!),
                            ),
                          // TODO: Handle property, room
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              children: _sm.buildTagsList(
                                state.item.uiTagsList ?? [],
                                context,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            )
          : const Center(child: Text('Something went wrong!')),
      floatingActionButton: args != null
          ? FloatingActionButton(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              onPressed: () => Navigator.pushNamed(
                context,
                EditItem.routeName,
                arguments: args,
              ),
              child: const Icon(Icons.edit_rounded),
            )
          : null,
    );
  }
}
