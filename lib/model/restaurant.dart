
import 'package:collection/collection.dart';
import 'package:delivery_app/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier{

  final List<Food> _menu = [
    //burger
    Food(
        name: "Hamburger",
        description: "Hamburger with juicy patty and everything you expected of burger",
        imagePath: "lib/images/burger/burger.png",
        price: 0.99,
        category: FoodCategory.burger,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
          AddOn(name: "Extra Patty", price: 0.99),
        ]
    ),
    Food(
        name: "Cheese Burger",
        description: "Hamburger with juicy patty and more cheese",
        imagePath: "lib/images/burger/cheese-burger.png",
        price: 0.99,
        category: FoodCategory.burger,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
          AddOn(name: "Extra Patty", price: 0.99),
        ]
    ),
    Food(
        name: "Big mac",
        description: "Hamburger in jumbo size",
        imagePath: "lib/images/burger/hamburger.png",
        price: 0.99,
        category: FoodCategory.burger,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
          AddOn(name: "Extra Patty", price: 0.99),
        ]
    ),

    //dessert
    Food(
        name: "Choco Cake",
        description: "Chocolate cake with choco filling",
        imagePath: "lib/images/dessert/cake.png",
        price: 0.99,
        category: FoodCategory.dessert,
        availableAddons: [
          AddOn(name: "Extra cream", price: 0.99),
          AddOn(name: "Extra cherry", price: 0.99),
        ]
    ),
    Food(
        name: "Cupcake",
        description: "Cupcake with strawberry frosting",
        imagePath: "lib/images/dessert/cupcake.png",
        price: 0.99,
        category: FoodCategory.dessert,
        availableAddons: [
          AddOn(name: "Extra frosting", price: 0.99),
          AddOn(name: "Extra sprinkle", price: 0.99),
          AddOn(name: "Extra cream", price: 0.99),
        ]
    ),
    Food(
        name: "Gelato",
        description: "Ice cream but Italy",
        imagePath: "lib/images/dessert/gelato.png",
        price: 0.99,
        category: FoodCategory.dessert,
        availableAddons: [
          AddOn(name: "Extra frosting", price: 0.99),
        ]
    ),

    //drink
    Food(
        name: "Cola",
        description: "Just what you expect from any cola",
        imagePath: "lib/images/drink/cola.png",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          AddOn(name: "Large glass", price: 0.99),

        ]
    ),
    Food(
        name: "Juice",
        description: "Juice from orange",
        imagePath: "lib/images/drink/juice.png",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          AddOn(name: "Extra sugar", price: 0.99),
          AddOn(name: "Large glass", price: 0.99),
        ]
    ),
    Food(
        name: "Soft Drink",
        description: "Soft drink with fruit flavoring",
        imagePath: "lib/images/drink/soft-drink.png",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          AddOn(name: "Extra cream", price: 0.99),

        ]
    ),

    //salad
    Food(
        name: "lettuce salad",
        description: "Salad with letuce",
        imagePath: "lib/images/salad/lettuce-salad.png",
        price: 0.99,
        category: FoodCategory.salad,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
        ]
    ),
    Food(
        name: "Salad",
        description: "Basic Salad",
        imagePath: "lib/images/salad/salad.png",
        price: 0.99,
        category: FoodCategory.salad,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
        ]
    ),
    Food(
        name: "Veggie Salad",
        description: "Salad but with more veggies",
        imagePath: "lib/images/salad/veggie-salad.png",
        price: 0.99,
        category: FoodCategory.salad,
        availableAddons: [
          AddOn(name: "Extra Veggie", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
        ]
    ),

    //sides
    Food(
        name: "French Fries",
        description: "Fried potatoes",
        imagePath: "lib/images/sides/french-fries.png",
        price: 0.99,
        category: FoodCategory.sides,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
          AddOn(name: "Extra sauce", price: 0.99),
        ]
    ),
    Food(
        name: "Fried Chicken",
        description: "Chicken but fried",
        imagePath: "lib/images/sides/fried-chicken.png",
        price: 0.99,
        category: FoodCategory.sides,
        availableAddons: [
          AddOn(name: "Extra cheese", price: 0.99),
          AddOn(name: "Extra Mayo", price: 0.99),
          AddOn(name: "Extra Flour", price: 0.99),
        ]
    ),
    Food(
        name: "Fried Egg",
        description: "Sunny side fried egg",
        imagePath: "lib/images/sides/fried-egg.png",
        price: 0.99,
        category: FoodCategory.sides,
        availableAddons: [
          AddOn(name: "Extra salt", price: 0.99),
        ]
    ),

  ];

  final List<CartItem> _cart = [];

  //delivery address(can be changed/update)
  String _deliveryAddress = 'Hollywood blv';

  //GETTER
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  //OPERATIONS



  //add to cart
  void addToCart(Food food, List<AddOn> selectedAddon) {
    //see if there is cart item within the same food and selected addon
    CartItem? cartItem = _cart.firstWhereOrNull((item) {

      bool isSameFood = item.food == food;

      bool isSameAddon = const ListEquality().equals(item.selectedAddons, selectedAddon);

      return isSameFood && isSameAddon;

    });

    //if item already exist, increase quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      // Otherwise, add to cart
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddon,
        ),
      );
    }
    notifyListeners();
  }

  //remove from carts
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if(cartIndex != -1) {
      if(_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else{
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  //get total number item in carts
  double getTotalPrice() {
    double total = 0.0;

    for(CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for(AddOn addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total+=itemTotal * cartItem.quantity;
    }

    return total;

  }

  //get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  //clear carts
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //update delivery addresss
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  //HELPERS

  //generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();

    //format date
    String formatedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    receipt.writeln(formatedDate);
    receipt.writeln();
    receipt.writeln("_______________");

    for (final cartItem in _cart) {
      receipt.writeln(" "
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");

      if(cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("  Add-ons: ${_formatAddons(cartItem.selectedAddons)} ");
      }
      receipt.writeln();
    }
    receipt.writeln("_______________");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln("______________");
    receipt.writeln("Delivering to: $deliveryAddress"  );

    return receipt.toString();
  }

  //format double into money
    String _formatPrice(double price){
      return "\$${price.toStringAsFixed(2)}";
    }

  // format list addons into string summary
  String _formatAddons(List<AddOn> addons) {
    return addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)}) " ).join(",");
  }

  
}