import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/drawer_item.dart';
import 'package:meals/screens/screens.dart';
import 'package:meals/providers/meals_provider.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filters, bool> selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(Screens identifier) async {
    Navigator.of(context).pop();
    switch (identifier) {
      case Screens.filter:
        final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
              filters: selectedFilters,
            ),
          ),
        );
        setState(() {
          selectedFilters = result ?? kInitialFilters;
        });

        break;
      case Screens.meal:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      } else if (selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      } else if (selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      } else if (selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      } else {
        return true;
      }
    }).toList();
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    ref.listen(favoriteMealsProvider, (prev, next) {
      final prevL = prev ?? [];
      final prevLength = prevL.length;
      final nextLength = next.length;
      if (prevLength > nextLength) {
        final meal = prevL.firstWhere((meal) {
          return !next.contains(meal);
        });
        _showInfoMessage("meal was unfavorited: ${meal.title}");
      } else if (prevLength < nextLength) {
        final meal = next.firstWhere((meal) {
          return !prevL.contains(meal);
        });
        _showInfoMessage("meal was favorited: ${meal.title}");
      }
    });

    Widget activePage = _selectedPageIndex == 0
        ? CategoriesScreen(
            meals: availableMeals,
          )
        : MealsScreen(
            title: null,
            meals: favoriteMeals,
          );
    String activePageTitle =
        _selectedPageIndex == 0 ? 'Categories' : 'Favorites';
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: DrawerItem(
        onSelectScreen: _selectScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.stars), label: 'Favorites'),
        ],
      ),
      body: activePage,
    );
  }
}
