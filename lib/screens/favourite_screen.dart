import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeal;
  FavouritesScreen(this.favouriteMeal);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeal.isEmpty) {
      return Container(
        child: Text("You hav no favourites yet - start adding some."),
      );
    } else {
      return ListView.builder(
          itemCount: favouriteMeal.length,
          itemBuilder: (context, index) {
            return MealItem(
              // removeItem: this._removeMeal,
              id: favouriteMeal[index].id,
              title: favouriteMeal[index].title,
              imageUrl: favouriteMeal[index].imageUrl,
              duration: favouriteMeal[index].duration,
              affordability: favouriteMeal[index].affordability,
              complexity: favouriteMeal[index].complexity,
            );
          },
        );
    }
  }
}
