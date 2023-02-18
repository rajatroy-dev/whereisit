import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/update_item_bloc.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';

class EditItem extends StatefulWidget {
  static const routeName = '/edit-item';

  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      var routeArgs = args as RouteArguments;
      if (routeArgs.hasParams) {
        BlocProvider.of<UpdateItemBloc>(context).add(
          UpdateItemAll(routeArgs.params!['id']!),
        );
      }
    }

    return Wrap(
      children: const [
        PillTag(
          title: '# This is a very large tag',
          isShort: false,
        ),
        PillTag(
          title: '# This is a large tag',
          isShort: false,
        ),
        PillTag(
          title: '# This is a large tag',
          isShort: false,
        ),
        PillTag(
          title: '# This is a large tag',
          isShort: false,
        ),
      ],
    );
  }
}
