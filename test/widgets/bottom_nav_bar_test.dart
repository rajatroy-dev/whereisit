import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:whereisit/widgets/bottom_nav_bar.dart';

void main() {
  testWidgets('renders BottomNavBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BottomNavBar(
          currentIndex: 0,
          onTap: (int i) {},
        ),
      ),
    );

    expect(
      find.byIcon(Icons.home_rounded),
      findsOneWidget,
    );
    expect(find.text('Home'), findsOneWidget);

    expect(
      find.byIcon(Icons.favorite_rounded),
      findsOneWidget,
    );
    expect(find.text('Favorites'), findsOneWidget);

    expect(
      find.byIcon(Icons.search_rounded),
      findsOneWidget,
    );
    expect(find.text('Search'), findsOneWidget);

    expect(
      find.byIcon(Icons.apps_rounded),
      findsOneWidget,
    );
    expect(find.text('All Items'), findsOneWidget);

    expect(
      find.byIcon(Icons.add_rounded),
      findsOneWidget,
    );
    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('successful BottomNavbar navigation',
      (WidgetTester tester) async {
    int currentIndex = 0;
    void onTap(int index) {
      currentIndex = index;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: BottomNavBar(currentIndex: currentIndex, onTap: onTap),
      ),
    );

    expect(currentIndex, 0);

    await tester.tap(find.byIcon(Icons.favorite_rounded));
    expect(currentIndex, 1);

    await tester.tap(find.byIcon(Icons.search_rounded));
    expect(currentIndex, 2);

    await tester.tap(find.byIcon(Icons.apps_rounded));
    expect(currentIndex, 3);

    await tester.tap(find.byIcon(Icons.add_rounded));
    expect(currentIndex, 4);
  });
}
