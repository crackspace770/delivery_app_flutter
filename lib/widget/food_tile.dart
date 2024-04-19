import 'package:flutter/material.dart';

import '../model/food.dart';

class FoodTile extends StatelessWidget {

  final Food food;
  final void Function()? onTap;

  const FoodTile ({super.key,
    required this.food,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [

                //text food detail
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(food.name),
                      Text('\$'+food.price.toString(), style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                      SizedBox(height: 10,),
                      Text(food.description,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),)
                    ],
                    )
                ),

                SizedBox(width: 15,),

                //food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                    child: Image.asset(food.imagePath, height: 120,)
                ),
            ],
            ),
          ),
        ),
         Divider(
           color: Theme.of(context).colorScheme.primary,
          endIndent: 25,
           indent: 25,
         )
      ],
    );
  }
}
