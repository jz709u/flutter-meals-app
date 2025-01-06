import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meals/models/meal.dart';
part 'filters_provider.g.dart';

enum Filters {
  vegetarian,
  vegan,
  glutenFree,
  lactoseFree,
}

@riverpod
class FiltersNotifier extends _$FiltersNotifier {
  @override
  Map<Filters, bool> build() {
    return {
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        };
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

@riverpod
List<Meal> filteredMeals(Ref ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersNotifierProvider);
  final availableMeals = meals.where((meal) {
    return !((filters[Filters.glutenFree]! && !meal.isGlutenFree) ||
        (filters[Filters.lactoseFree]! && !meal.isLactoseFree) ||
        (filters[Filters.vegan]! && !meal.isVegan) ||
        (filters[Filters.vegetarian]! && !meal.isVegetarian));
  }).toList();
  return availableMeals;
}