import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'meals_provider.g.dart';

@riverpod
List<Meal> meals(Ref ref) {
  return dummyMeals;
}
