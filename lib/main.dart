// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase database = FirebaseDatabase.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recipe App',
      home: IngredientsApp(),
    );
  }
}

class IngredientsApp extends StatefulWidget {
  const IngredientsApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IngredientsAppState createState() => _IngredientsAppState();
}

class _IngredientsAppState extends State<IngredientsApp> {
  List<String> ingredients = [
    'Bananas',
    'Blueberries',
    'Flour',
    'Milk',
    'Butter',
    'Cinnamon',
    'Vanilla Extract',
    'Salt',
    'Nutmeg',
    'Baking Soda',
    'Baking Powder',
    'Eggs',
    'Olive Oil',
    'Carrots',
    'Graham Crackers',
    'Yeast',
    'Brown Sugar',
    'Powdered Sugar',
    'Cream Cheese',
    'Lemons',
    'Maple Syrup',
    'Applesauce',
    'Vegetable Oil',
    'Peanut Butter',
    'Water',
    'Chocolate'
  ];
  List<String> selectedIngredients = [];

  Map<String, List<String>> recipes = {
    'Banana Bread': [
      'Bananas',
      'Flour',
      'Vegetable Oil',
      'Eggs',
      'Baking Soda',
      'Sugar',
      'Vanilla Extract',
      'Cinnamon',
      'Nutmeg',
      'Salt'
    ],
    'Blueberry Muffins': [
      'Flour',
      'Baking Powder',
      'Eggs',
      'Olive Oil',
      'Milk',
      'Sugar',
      'Vanilla Extract',
      'Cinnamon',
      'Blueberries'
    ],
    'Brownies': ['Baking Powder', 'Butter', 'Eggs', 'Water', 'Chocolate'],
    'Cake': ['Flour', 'Eggs', 'Sugar', 'Milk', 'Vanilla Extract'],
    'Carrot Cake': [
      'Carrots',
      'Flour',
      'Baking Soda',
      'Eggs',
      'Maple Syrup',
      'Applesauce',
      'Milk',
      'Vegetable Oil',
      'Cinnamon',
      'Vanilla Extract',
      'Nutmeg',
      'Salt'
    ],
    'Cheesecake': [
      'Graham Crackers',
      'Cinnamon',
      'Butter',
      'Eggs',
      'Cream Cheese',
      'Sugar',
      'Sour Cream',
      'Lemon',
      'Vanilla Extract'
    ],
    'Cinnamon Rolls': [
      'Flour',
      'Sugar',
      'Salt',
      'Milk',
      'Butter',
      'Egg',
      'Cinnamon',
      'Brown Sugar',
      'Yeast'
    ],
    'Cookies': ['Eggs', 'Brown Sugar', 'Sugar', 'Flour', 'Butter'],
    'Oatmeal cookies': [
      'Flour',
      'Brown Sugar',
      'Baking Powder',
      'Baking Soda',
      'Salt',
      'Butter',
      'Eggs',
      'Raisins',
      'Vanilla Extract'
    ],
    'Peanut Butter Cookies': [
      'Peanut Butter',
      'Flour',
      'Baking Soda',
      'Butter',
      'Brown Sugar',
      'Eggs',
      'Vanilla Extract',
      'Salt'
    ],
    'Sugar Cookies': [
      'Flour',
      'Baking Powder',
      'Salt',
      'Butter',
      'Salt',
      'Eggs',
      'Milk',
      'Powdered Sugar'
    ],
  };

  void _findMatchingRecipes() {
    List<String> matchingRecipes = [];

    recipes.forEach((recipe, ingredientsList) {
      if (selectedIngredients
          .every((ingredient) => ingredientsList.contains(ingredient))) {
        matchingRecipes.add(recipe);
      }
    });

    if (matchingRecipes.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Matching Recipes'),
            content:
                Text('Matching recipes found:\n${matchingRecipes.join(', ')}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Matching Recipes'),
            content: const Text('No recipes match the selected ingredients.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: ingredients.isNotEmpty ? ingredients[0] : null,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    selectedIngredients.add(value);
                    ingredients.remove(value);
                  }
                });
              },
              items: ingredients.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (selectedIngredients.isNotEmpty) {
                        ingredients.add(selectedIngredients.removeLast());
                      }
                    });
                  },
                  child: const Text('Remove'),
                ),
                ElevatedButton(
                  onPressed: _findMatchingRecipes,
                  child: const Text('GO!'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: selectedIngredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedIngredients[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
