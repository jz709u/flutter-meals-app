import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_header_item.dart';
import 'package:meals/providers/favorite_meals_provider.dart';

class MealsDetailScreen extends ConsumerWidget {
  const MealsDetailScreen({super.key, required this.meal});
  final Meal meal;

  void _showInfoMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {
              final result = ref
                  .read(favoriteMealsNotifierProvider.notifier)
                  .toggleMealFavoriteStates(meal);
              _showInfoMessage(
                result ? "favorite meal added" : "favorite meal removed",
                context,
              );
            },
            isSelected: favoriteMeals.contains(meal),
            selectedIcon: Icon(
              Icons.star,
            ),
            icon: Icon(
              Icons.star_border,
              color: Colors.white24,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          SizedBox(
            height: 320,
            child: MealHeaderItem(meal: meal),
          ),
          content(context)
        ],
      ),
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingrediants",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 14,
          ),
          for (final ingrediant in meal.ingredients)
            Text(
              '- $ingrediant',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          const SizedBox(
            height: 14,
          ),
          Text(
            "Steps",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 14,
          ),
          ...indexMealsSteps(meal.steps, context),
        ],
      ),
    );
  }

  List<Widget> indexMealsSteps(List<String> steps, BuildContext context) {
    List<String> titles = [];
    steps
      .asMap()
      .forEach((index, value) {
        titles += ["${index + 1} $value"];
      });

    return titles
    .map((result) => Text(
        result, 
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface))
    )
    .toList();
  }
}
