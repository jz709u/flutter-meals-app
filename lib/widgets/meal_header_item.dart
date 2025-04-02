import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealHeaderItem extends StatelessWidget {
  const MealHeaderItem({super.key, required this.meal});
  final Meal meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: meal.id,
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
            fit: BoxFit.fitHeight,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Container(
          color: Colors.black38,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 44),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 140,
                mainAxisSpacing: 0,
                mainAxisExtent: 20,
              ),
              children: [
                MealItemTrait(
                  icon: Icons.schedule, 
                  label: '${meal.duration} min',
                ),
                MealItemTrait(
                  icon: Icons.work,
                  label: complexityText,
                ),
                MealItemTrait(
                  icon: Icons.attach_money,
                  label: affordabilityText,
                ),
                // MealItemTrait(
                //   icon: Icons.food_bank,
                //   label: meal.isGlutenFree ? 'gluten-free' : '',
                // ),
                // MealItemTrait(
                //   icon: Icons.my_library_books,
                //   label: meal.isLactoseFree ? 'lactose-free' : '',
                // ),
                // MealItemTrait(
                //   icon: Icons.attach_money,
                //   label: meal.isVegan ? 'Vegan' : '',
                // ),
                // MealItemTrait(
                //   icon: Icons.attach_money,
                //   label: meal.isVegetarian ? 'Vegetarian' : '',
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
