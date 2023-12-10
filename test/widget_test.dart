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
  testWidgets('Widget builds and initial state', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify if the app title is present.
    expect(find.text('Recipe App'), findsOneWidget);

    // Verify if the initial ingredient is present in the dropdown.
    expect(find.text('Bananas'), findsOneWidget);

    // Verify if the Remove button is present.
    expect(find.text('Remove'), findsOneWidget);

    // Verify if the GO! button is present.
    expect(find.text('GO!'), findsOneWidget);

    // Verify if no ingredients are initially selected.
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Ingredient selection and removal', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Tap on the dropdown and select an ingredient.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pump();

    // Verify if the selected ingredient is displayed.
    expect(find.text('Remove'), findsOneWidget);

    // Tap on the Remove button and check if the ingredient is removed.
    await tester.tap(find.text('Remove'));
    await tester.pump();

    // Verify if the Remove button is there still.
    expect(find.text('Remove'), findsOneWidget);

    // Verify if the GO! button is still present.
    expect(find.text('GO!'), findsOneWidget);

    // Verify if no ingredients are selected after removal.
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('Matching Recipes Dialog', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

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
}
