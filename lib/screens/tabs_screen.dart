import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/drawer_item.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _toggleMealFavoriteStatus(Meal meal) {
    setState(() {
      if (!_favoriteMeals.contains(meal)) {
        _favoriteMeals.add(meal);
        _showInfoMessage('Favorited meal ${meal.title}');
      } else {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Removed Favorite Meal ${meal.title}');
      }
    });
  }

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

  void _selectScreen(Screens identifier) {
    switch (identifier) {
      case Screens.filter:

      case Screens.meal:
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = _selectedPageIndex == 0
        ? CategoriesScreen(
            onToggleFavorite: _toggleMealFavoriteStatus,
          )
        : MealsScreen(
            title: null,
            meals: _favoriteMeals,
            onToggleFavorite: _toggleMealFavoriteStatus,
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
