import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_header_item.dart';
import 'package:meals/providers/favorites_provider.dart';

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
    final favoriteMeals = ref.watch(favoriteMealsProvider);

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
                  .read(favoriteMealsProvider.notifier)
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
          ...meal.steps.indexed.map((x) => Text(
                '${x.$1 + 1} ${x.$2}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              )),
        ],
      ),
    );
  }
}
