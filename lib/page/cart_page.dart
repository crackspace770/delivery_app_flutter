
import 'package:delivery_app/model/restaurant.dart';
import 'package:delivery_app/page/payment_page.dart';
import 'package:delivery_app/widget/cart_tile.dart';
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
          actions: [
            //clear all carts
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context)=> AlertDialog(
                        title: Text("Are you sure want to clear all the cart?"),
                        actions: [
                          
                          //cancel
                          TextButton(onPressed: () => Navigator.pop(context),
                              child: Text("Cancel")
                          ),
                          
                          //yes
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();

                          },
                              child: Text("Yes")
                          ),
                        ],
                      )
                  );
                },
                icon: Icon(Icons.delete))
          ],

        ),
        body: Column(
          children: [
            //list of carts
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Expanded(child: Center(child: Text("Cart Empty"),
                    ),
                  )
                      : Expanded(
                      child: ListView.builder(
                        itemCount: userCart.length,
                          itemBuilder: (context, index) {
                          final cartItem = userCart[index];
              
                          return CartTile(cartItem: cartItem);
                          }
              
                      ),
                  ),
              
              ],
              ),
            ),

            //pay button
            GestureDetector(
              onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage() ) ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text('Checkout',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary
                          ),
                        )),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25)
          ],
        ),
      );
    },
    );
  }
}
