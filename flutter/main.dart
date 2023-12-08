import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      home: IngredientsApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IngredientsApp extends StatefulWidget {
  @override
  _IngredientsAppState createState() => _IngredientsAppState();
}

class _IngredientsAppState extends State<IngredientsApp> {
  List<String> selectedIngredients = [];
  List<String> ingredients = [];
  Map<String, dynamic> recipes = {};

  // Function to fetch recipes from Firebase
  Future getRecipes() async {
    var url = Uri.parse(
        "https://recipeapp-98710-default-rtdb.firebaseio.com/recipes.json");

    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Successful response
        var results = jsonDecode(response.body);
        if (results is Map<String, dynamic>) {
          setState(() {
            recipes = results;
          });
        } else {
          print('Error: Unexpected data format from Firebase');
        }
        //adds all of the unique ingredients to a list
        for (var recipe in recipes.values) {
          if (recipe['ingredients'] != null) {
            List<String> ingrdtList = List<String>.from(recipe['ingredients']);
            for (String ingrdt in ingrdtList) {
              if (!ingredients.contains(ingrdt)) {
                ingredients.add(ingrdt);
              }
            }
          }
        }
        ingredients.sort();
      } else {
        // Handle the error, for example, print the status code
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error fetching data: $error');
    }
  }

  // Initialize recipes when the app starts
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  // Function to find matching recipes based on selected ingredients
  void _findMatchingRecipes() {
    List<String> matchingRecipes = [];

    recipes.forEach((recipe, recipeData) {
      List<String> ingredientsList =
          List<String>.from(recipeData['ingredients']);

      //if the ingredients the user selected are in the recipe it is a match
      if (selectedIngredients
          .every((ingredient) => ingredientsList.contains(ingredient))) {
        matchingRecipes.add(recipe);
      }
    });
    //
    if (matchingRecipes.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Matching Recipes'),
            content: Column(
              children: matchingRecipes.map((recipe) {
                String recipeUrl = recipes[recipe]['url'] ??
                    ''; // Retrieve the URL from the recipe data
                return GestureDetector(
                  onTap: () {
                    // Open the URL when the recipe name is tapped
                    if (recipeUrl.isNotEmpty) {
                      launch(recipeUrl);
                    }
                  },
                  child: Text(
                    '$recipe',
                    style: TextStyle(
                      color: Colors.blue, // You can customize the link color
                      decoration: TextDecoration.underline,
                    ),
                  ),
                );
              }).toList(),
            ),
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
                        ingredients.sort();
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
