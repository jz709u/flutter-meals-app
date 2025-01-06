import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorite_meals_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/drawer_item.dart';
import 'package:meals/screens/screens.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(Screens identifier) async {
    Navigator.of(context).pop();
    switch (identifier) {
      case Screens.filter:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(),
          ),
        );
        break;
      case Screens.meal:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(filteredMealsProvider);
    final favoriteMeals = ref.watch(favoriteMealsNotifierProvider);

    Widget activePage = _selectedPageIndex == 0
        ? CategoriesScreen(
            meals: meals,
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
