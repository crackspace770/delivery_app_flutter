import 'package:delivery_app/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;

  const CartTile({
    super.key,
    required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, restaurant, child)
    =>Container(
      child: Column
        (
        children: [
          Row(
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
              Text(cartItem.food.name),
              Text(cartItem.food.price.toString())
              ],
              ),
              
              //increment or decrement quantity
            ],
          ),
      ],
      ),
    ),
    );
  }
}
