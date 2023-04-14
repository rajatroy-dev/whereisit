import 'package:flutter/material.dart';
import 'package:whereisit/screens/category_subcategory/accordian/accordian.view.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class CategorySubcategoryScreen extends StatelessWidget {
  const CategorySubcategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: const [
          Accordion(
            title: 'Section #1',
            content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Nam bibendum ornare vulputate. Curabitur faucibus condimentum '
                'purus quis tristique.',
          ),
          Accordion(
              title: 'Section #2',
              content: 'Fusce ex mi, commodo ut bibendum sit amet, faucibus ac '
                  'felis. Nullam vel accumsan turpis, quis pretium ipsum. '
                  'Pellentesque tristique, diam at congue viverra, neque dolor'
                  ' suscipit justo, vitae elementum leo sem vel ipsum'),
          Accordion(
              title: 'Section #3',
              content:
                  'Nulla facilisi. Donec a bibendum metus. Fusce tristique ex '
                  'lacus, ac finibus quam semper eu. Ut maximus, enim eu '
                  'ornare fringilla, metus neque luctus est, rutrum accumsan '
                  'nibh ipsum in erat. Morbi tristique accumsan odio quis '
                  'luctus.'),
        ],
      ),
    );
  }
}
