import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/categories_screens.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favouriteMeal = [];

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filter['gluten'] && !meal.isGlutenFree) {
          return false;
        } else if (_filter['lactose'] && !meal.isLactoseFree) {
          return false;
        } else if (_filter['vegan'] && !meal.isVegan) {
          return false;
        } else if (_filter['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeal.any((meal)=> meal.id == id);

  }

  void _toggleFavourite(String mealId) {
    final existingIndex =_favouriteMeal.indexWhere((meal)=> meal.id == mealId);
    if(existingIndex >= 0) {
      setState(() {
        _favouriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme : ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        // '/': (context) => CategoriesScreen(),
        '/': (context) => TabsScreen(_favouriteMeal),
        FilterScreen.routeName: (context) => FilterScreen(this._filter,this._setFilter),
        MealDetailScreen.routeName: (context) => MealDetailScreen(this._toggleFavourite,this._isMealFavourite),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeal),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
