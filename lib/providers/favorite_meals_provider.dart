//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
part 'favorite_meals_provider.g.dart';

@riverpod
class FavoriteMealsNotifier extends _$FavoriteMealsNotifier {
  @override
  List<Meal> build() => [];

  bool toggleMealFavoriteStates(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((x) {
        return x.id != meal.id;
      }).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}