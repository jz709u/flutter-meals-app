import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.meals});
  final List<Meal> meals;

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      final xmeals = meals
          .where(
            (meal) => meal.categories.contains(
              category.id,
            ),
          )
          .toList();
      return MealsScreen(
        title: category.title,
        meals: xmeals,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category,
            onTap: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
