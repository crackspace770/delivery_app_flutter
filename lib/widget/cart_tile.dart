
import 'package:delivery_app/model/cart_item.dart';
import 'package:delivery_app/model/restaurant.dart';
import 'package:delivery_app/widget/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;

  const CartTile({
    super.key,
    required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) =>Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column
        (
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                //food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    cartItem.food.imagePath,
                    height: 100,
                    width: 100,
                  ),
                ),

                SizedBox(height: 10),

                //food name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //food name
                Text(cartItem.food.name),

                //food price
                Text('\$${cartItem.food.price}',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                const SizedBox(height: 10),

                    QuantitySelector(
                        quantity: cartItem.quantity,
                        food: cartItem.food,
                        onIncrement: () {
                          restaurant.addToCart(cartItem.food, cartItem.selectedAddons);
                        },
                        onDecrement: () {
                          restaurant.removeFromCart(cartItem);
                        }
                    ),

                ],
                ),

                const Spacer(),

                //increment or decrement quantity

              ],
            ),
          ),

          //addons
          SizedBox(
            height: cartItem.selectedAddons.isEmpty ? 0:60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
              children:  cartItem.selectedAddons
                  .map(
                    (addon) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                      label: Row(
                      children: [
                        //addon Name
                        Text(addon.name),
                      //addon price
                      Text('\$${addon.price}')
                      ],
                                        ),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                      color: Theme.of(context).colorScheme.primary
                                        )
                                      ),
                                      onSelected: (value) {},
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.inversePrimary,
                                        fontSize: 12
                                      ),
                                    ),
                    )).toList(),
              ),
            ),

      ],
      ),
    ),
    );
  }
}
