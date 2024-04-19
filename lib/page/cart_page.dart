
import 'package:delivery_app/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
    //cart
      final userCart = restaurant.cart;

      //scaffold ui
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,

        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: userCart.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(userCart[index].food.name),
                    ) 
                    
                ),
            ),

        ],
        ),
      );
    },
    );
  }
}
