import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filters {
  vegetarian,
  vegan,
  glutenFree,
  lactoseFree,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);
  final availableMeals = meals.where((meal) {
    return !((filters[Filters.glutenFree]! && !meal.isGlutenFree) ||
        (filters[Filters.lactoseFree]! && !meal.isLactoseFree) ||
        (filters[Filters.vegan]! && !meal.isVegan) ||
        (filters[Filters.vegetarian]! && !meal.isVegetarian));
  }).toList();
  return availableMeals;
});
