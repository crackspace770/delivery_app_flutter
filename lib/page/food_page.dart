import 'package:delivery_app/model/food.dart';
import 'package:delivery_app/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class FoodPage extends StatefulWidget {

  final Food food;
  final Map<AddOn,bool> selectedAddOn = {};

  FoodPage({
    super.key,
    required this.food,
  }) {
    //init add on
    for(AddOn addOn in food.availableAddons) {
      selectedAddOn[addOn] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  void addToCart(Food food, Map<AddOn, bool> selectedAddons) async {
    // format the list of selected addon
    List<AddOn> currentlySelectedAddons = [];
    // list of individual addon
    for (AddOn addon in widget.food.availableAddons) {
      if (widget.selectedAddOn[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    // add to cart
     context.read<Restaurant>().addToCart(food, currentlySelectedAddons);

    // close the current food back then go back to home menu
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(

              children: [
                Image.asset(widget.food.imagePath),

                //food name
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.food.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),)
                      ,

                      Text('\$${widget.food.price}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary
                        ),
                      ),

                      const SizedBox(height: 10,),

                      //food description
                      Text(widget.food.description,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary
                        ),
                      ),

                      Divider(color: Theme.of(context).colorScheme.secondary),

                      const SizedBox(height: 10,),

                      Text("Add-ons",
                        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),

                      ),
                      //add ons
                      //add ons
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.secondary),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddons.length, // Set itemCount to the length of availableAddons
                          itemBuilder: (context, index ) {
                            // Check if index is valid

                              AddOn addon = widget.food.availableAddons[index];

                              return CheckboxListTile(
                                title: Text(addon.name),
                                subtitle: Text('\$${addon.price}',
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                ),
                                value: widget.selectedAddOn[addon],
                                onChanged: (bool? value) {
                                  setState(() {
                                    widget.selectedAddOn[addon] = value!;
                                  });
                                },
                              );

                          },
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 15),

                //button cart
                // button cart
                GestureDetector(
                  onTap: () => addToCart(widget.food, widget.selectedAddOn),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Text('Add to Cart',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.inversePrimary
                              ),
                            )),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15)

              ],
            ),
          ),

        ),
        //back button
        SafeArea(
          child: Opacity(
            opacity: 0.5,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: ()=>Navigator.pop(context), // Changed this line
              ),
            ),
          ),
        ),
      ],

    );
  }
}
