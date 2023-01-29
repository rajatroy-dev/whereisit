import 'package:flutter/material.dart';

class SortFilter extends StatelessWidget {
  final void Function() sortHandler;

  const SortFilter({
    Key? key,
    required this.sortHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.purple,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InkWell(
                splashColor: Colors.purple[100],
                onTap: sortHandler,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.sort_rounded,
                          color: Colors.purple,
                        ),
                      ),
                      Text('Sort'),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              color: Colors.purple,
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.purple[100],
                onTap: () {},
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.purple,
                        ),
                      ),
                      Text('Filter'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
