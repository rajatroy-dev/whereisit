import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/horizontal_image_list_container/horizontal_image_list_container.viewgroup.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';

class ViewItemScreen extends StatelessWidget {
  static const routeName = '/view-item';

  const ViewItemScreen({Key? key}) : super(key: key);

  List<Widget> _buildTagsList(List<Tag> tags, BuildContext context) {
    var pillTagsList = <Widget>[];
    for (var element in tags) {
      if (element.isSelected!) {
        pillTagsList.add(
          PillTag(
            title: '#${element.item}',
            isShort: false,
            hasDelete: true,
            handleDelete: () => BlocProvider.of<EditItemBloc>(context).add(
              EditItemTagRemove(element.item),
            ),
          ),
        );
      }
    }

    return pillTagsList;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is String) {
      BlocProvider.of<EditItemBloc>(context).add(EditItemLoadExisting(args));
    }

    return AppScaffold(
      action: AppBarAction.edit,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<EditItemBloc, EditItemState>(
          builder: (context, state) {
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    state.item.quantity != null
                        ? state.item.quantity.toString()
                        : '0',
                  ),
                ),
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
                    children: _buildTagsList(
                      state.item.uiTagsList ?? [],
                      context,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
