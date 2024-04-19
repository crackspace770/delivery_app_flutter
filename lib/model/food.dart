import 'dart:ffi';

class Food{
  final String name;
  final String description;
  final imagePath;
  final double price;
  final FoodCategory category;
  List<AddOn> availableAddons;

  Food( {
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons
    });

}

//food category

enum FoodCategory{
  burger,
  salad,
  sides,
  dessert,
  drinks
}

class AddOn{
  String name;
  double price;

  AddOn({
    required this.name,
    required this.price

  });

}