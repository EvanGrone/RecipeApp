// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_github_workflow/main.dart';

void main() {
  testWidgets('Test Recipe App', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Ensure the initial UI is displayed
    expect(find.text('Recipe App'), findsOneWidget);
    expect(find.text('Bananas'), findsOneWidget);

    // Tap on the dropdown button
    await tester.tap(find.byKey(const Key('dropdownButton')));
    await tester.pump();

    // Tap on the first ingredient in the dropdown
    await tester.tap(
        find.text('Bananas').last); // Use last to select the second instance
    await tester.pump();

    // Check if the ingredient is added to the selected ingredients
    expect(find.text('Bananas'), findsNothing);
    expect(find.text('Remove'), findsOneWidget);

    // Tap on the "GO!" button
    await tester.tap(find.text('GO!'));
    await tester.pumpAndSettle();

    // Check if the "Matching Recipes" dialog is displayed
    expect(find.text('Matching Recipes'), findsOneWidget);
    expect(find.text('Banana Bread'), findsOneWidget);

    // Tap on the "OK" button in the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Check if the dialog is closed
    expect(find.text('Matching Recipes'), findsNothing);
  });
}
