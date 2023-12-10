// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_github_workflow/main.dart';

void main() {
  testWidgets('Widget builds', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify if the title is present in the app.
    expect(find.text('Recipe App'), findsOneWidget);
  });

  testWidgets('Ingredient selection', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on the dropdown and select an ingredient.
    await tester.tap(find.byType(DropdownButton<dynamic>));
    await tester.pump();

    // Verify if the selected ingredient is displayed.
    expect(find.text('Remove'), findsOneWidget);

    // Tap on the Remove button and check if the ingredient is removed.
    await tester.tap(find.text('Remove'));
    await tester.pump();

    expect(find.text('Remove'), findsOneWidget);
  });
}
