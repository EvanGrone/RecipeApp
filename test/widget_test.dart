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
  testWidgets('Find Matching Recipes Dialog', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Set up some selected ingredients
    final ingredientsApp =
        tester.firstWidget(find.byType(IngredientsApp)) as IngredientsApp;
    final ingredientsAppState = ingredientsApp.createState();

    ingredientsAppState.selectedIngredients = [
      'Flour',
      'Eggs',
      'Sugar',
    ];

    // Trigger the _findMatchingRecipes method
    await ingredientsAppState._findMatchingRecipes();

    // Wait for the dialog to appear
    await tester.pumpAndSettle();

    // Verify that the dialog is shown
    expect(find.text('Matching Recipes'), findsOneWidget);
    expect(find.text('Blueberry Muffins'), findsOneWidget);
  });

  testWidgets('No Matching Recipes Dialog', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Set up some selected ingredients
    const ingredientsAppState = IngredientsApp();

    ingredientsAppState.selectedIngredients = [
      'Chocolate',
      'Water',
    ];

    // Trigger the _findMatchingRecipes method
    await ingredientsAppState._findMatchingRecipes();

    // Wait for the dialog to appear
    await tester.pumpAndSettle();

    // Verify that the dialog is shown
    expect(find.text('No Matching Recipes'), findsOneWidget);
    expect(
      find.text('No recipes match the selected ingredients.'),
      findsOneWidget,
    );
  });

  testWidgets('Widget Test - Dropdown and Buttons',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial state is correct
    expect(find.text('Remove'), findsNothing);
    expect(find.text('GO!'), findsOneWidget);

    // Select an ingredient from the dropdown
    await tester.tap(find.byType(DropdownButton));
    await tester.pumpAndSettle();

    // Verify that the ingredient is selected
    expect(find.text('Remove'), findsOneWidget);
    expect(find.text('GO!'), findsOneWidget);

    // Remove the selected ingredient
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();

    // Verify that the ingredient is removed
    expect(find.text('Remove'), findsNothing);
    expect(find.text('GO!'), findsOneWidget);
  });
}
