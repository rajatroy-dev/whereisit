import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class HorizontalListImage extends StatelessWidget {
  final String image;
  final bool isDeletable;

  const HorizontalListImage({
    Key? key,
    required this.image,
    required this.isDeletable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: A better way to render this?
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            Image.file(
              File(image),
            ),
            if (isDeletable)
              Positioned(
                right: -10,
                top: -10,
                child: IconButton(
                  onPressed: () => BlocProvider.of<EditItemBloc>(context).add(
                    EditItemImageRemove(image),
                  ),
                  icon: const Icon(
                    Icons.cancel_rounded,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 15.0),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
