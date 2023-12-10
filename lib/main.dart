// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase database = FirebaseDatabase.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  List<String> selectedIngredients = [];
  List<String> ingredients = [];

  Map<String, dynamic> recipes = {};

  Future getRecipes() async {
    var url =
        Uri.parse("https://recipeapp-98710-default-rtdb.firebaseio.com/.json");

    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Successful response
        var results = jsonDecode(response.body);
        //print('results $results');
        setState(() {
          recipes = results;
        });

        for (var entry in recipes.entries) {
          //dynamic key = entry.key;
          var value = entry.value;
          List<String> ingrdtList = value.split(', ');
          for (String ingrdt in ingrdtList) {
            if (!ingredients.contains(ingrdt)) {
              if (kDebugMode) {
                print(ingrdt);
              }
              ingredients.add(ingrdt);
            }
          }
        }
        ingredients.sort();
      } else {
        // Handle the error, for example, print the status code
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
      }
    } catch (error) {
      // Handle network or other errors
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

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
            DropdownButton<dynamic>(
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
