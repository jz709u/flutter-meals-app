import 'package:flutter/material.dart';
import 'package:meals/screens/screens.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/widgets/drawer_item.dart';

enum Filters {
  vegetarian,
  vegan,
  glutenFree,
  lactoseFree,
}

class FiltersScreen extends StatefulWidget {
  FiltersScreen({super.key, required this.filters});
  Map<Filters, bool> filters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    _glutenFreeFilterSet = widget.filters[Filters.glutenFree] ?? false;
    _lactoseFreeFilterSet = widget.filters[Filters.lactoseFree] ?? false;
    _vegetarianFilterSet = widget.filters[Filters.vegetarian] ?? false;
    _veganFilterSet = widget.filters[Filters.vegan] ?? false;
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: DrawerItem(onSelectScreen: (screen) {
      //   Navigator.of(context).pop();
      //   if (screen == Screens.meal) {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      //       return TabsScreen();
      //     }));
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) { return; }
          Navigator.of(context).pop({
            Filters.glutenFree: _glutenFreeFilterSet,
            Filters.lactoseFree: _lactoseFreeFilterSet,
            Filters.vegetarian: _vegetarianFilterSet,
            Filters.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            _filterRow(
              'Gluten-free',
              'Only include gluten-free meals.',
              _glutenFreeFilterSet,
              (newValue) {
                _glutenFreeFilterSet = newValue;
              },
            ),
            _filterRow(
              'Lactose-free',
              'Only include Lactose-free meals.',
              _lactoseFreeFilterSet,
              (newValue) {
                _lactoseFreeFilterSet = newValue;
              },
            ),
            _filterRow(
              'Vegetarian',
              'Only include vegetarian meals.',
              _vegetarianFilterSet,
              (newValue) {
                _vegetarianFilterSet = newValue;
              },
            ),
            _filterRow(
              'Vegan',
              'Only include vegan meals.',
              _veganFilterSet,
              (newValue) {
                _veganFilterSet = newValue;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterRow(
    String title,
    String subtitle,
    bool value,
    Function(bool set) onChange,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (on) {
        setState(() {
          onChange(on);
        });
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
