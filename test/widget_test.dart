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
    await tester.pumpWidget(const MyApp());
    expect(find.text('Recipe App'), findsOneWidget);
  });

  testWidgets('Ingredient selection and removal', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap on the dropdown and select an ingredient.
    await tester.tap(find.byType(DropdownButton<dynamic>));
    await tester.pump();

    // Verify if the selected ingredient is displayed.
    expect(find.text('Remove'), findsOneWidget);

    // Tap on the Remove button and check if the ingredient is removed.
    await tester.tap(find.text('Remove'));
    await tester.pump();

    // Verify if the Remove button is removed.
    expect(find.text('Remove'), findsNothing);
  });

  testWidgets('Matching Recipes Dialog', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap on the GO! button.
    await tester.tap(find.text('GO!'));
    await tester.pumpAndSettle();

    // Verify if the matching recipes dialog is displayed.
    expect(find.text('Matching Recipes'), findsOneWidget);

    // Tap on OK to close the dialog.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify if the dialog is closed.
    expect(find.text('Matching Recipes'), findsNothing);
  });

  testWidgets('Add and Remove Ingredients', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap on the dropdown and select an ingredient.
    await tester.tap(find.byType(DropdownButton<dynamic>));
    await tester.pump();

    // Verify if the selected ingredient is displayed.
    expect(find.text('Remove'), findsOneWidget);

    // Tap on the Remove button and check if the ingredient is removed.
    await tester.tap(find.text('Remove'));
    await tester.pump();

    // Verify if the Remove button is removed.
    expect(find.text('Remove'), findsNothing);

    // Verify if the GO! button is still present.
    expect(find.text('GO!'), findsOneWidget);
  });
}
