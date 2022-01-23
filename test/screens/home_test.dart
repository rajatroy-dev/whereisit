import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:whereisit/ui/screens/home.dart';

void main() {
  testWidgets('renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeScreen(),
        ),
      ),
    );

    expect(find.text('Property'), findsOneWidget);
    expect(find.byIcon(Icons.apartment_rounded), findsOneWidget);

    expect(find.text('Room'), findsOneWidget);
    expect(find.byIcon(Icons.space_dashboard_outlined), findsOneWidget);

    expect(find.text('Area'), findsOneWidget);
    expect(find.byIcon(Icons.all_inbox_rounded), findsOneWidget);

    expect(find.text('Item'), findsOneWidget);
    expect(find.byIcon(Icons.move_to_inbox_rounded), findsOneWidget);
  });
}
