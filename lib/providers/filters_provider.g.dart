// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredMealsHash() => r'5860f8218596cd9ac20b8331e770776b88622363';

/// See also [filteredMeals].
@ProviderFor(filteredMeals)
final filteredMealsProvider = AutoDisposeProvider<List<Meal>>.internal(
  filteredMeals,
  name: r'filteredMealsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredMealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredMealsRef = AutoDisposeProviderRef<List<Meal>>;
String _$filtersNotifierHash() => r'7d8abfdf0005af44adf42e3fbc3687937d243949';

/// See also [FiltersNotifier].
@ProviderFor(FiltersNotifier)
final filtersNotifierProvider =
    AutoDisposeNotifierProvider<FiltersNotifier, Map<Filters, bool>>.internal(
  FiltersNotifier.new,
  name: r'filtersNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filtersNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FiltersNotifier = AutoDisposeNotifier<Map<Filters, bool>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
