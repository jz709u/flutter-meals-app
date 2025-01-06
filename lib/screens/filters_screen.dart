import 'package:flutter/material.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final filters = ref.watch(filtersNotifierProvider);

    final glutenFreeFilterSet = filters[Filters.glutenFree] ?? false;
    final lactoseFreeFilterSet = filters[Filters.lactoseFree] ?? false;
    final vegetarianFilterSet = filters[Filters.vegetarian] ?? false;
    final veganFilterSet = filters[Filters.vegan] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          _filterRow(
            'Gluten-free',
            'Only include gluten-free meals.',
            glutenFreeFilterSet,
            context,
            (newValue) {
              ref
                .read(filtersNotifierProvider.notifier)
                .setFilter(Filters.glutenFree, newValue);
            },
          ),
          _filterRow(
            'Lactose-free',
            'Only include Lactose-free meals.',
            lactoseFreeFilterSet,
            context,
            (newValue) {
              ref
                .read(filtersNotifierProvider.notifier)
                .setFilter(Filters.lactoseFree, newValue);
            },
          ),
          _filterRow(
            'Vegetarian',
            'Only include vegetarian meals.',
            vegetarianFilterSet,
            context,
            (newValue) {
              ref
                .read(filtersNotifierProvider.notifier)
                .setFilter(Filters.vegetarian, newValue);
            },
          ),
          _filterRow(
            'Vegan',
            'Only include vegan meals.',
            veganFilterSet,
            context,
            (newValue) {
              ref
                .read(filtersNotifierProvider.notifier)
                .setFilter(Filters.vegan, newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget _filterRow(
    String title,
    String subtitle,
    bool value,
    BuildContext context,
    Function(bool set) onChange,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (on) {
        onChange(on);
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
