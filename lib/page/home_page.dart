import 'package:delivery_app/model/food.dart';
import 'package:delivery_app/model/restaurant.dart';
import 'package:delivery_app/page/food_page.dart';
import 'package:delivery_app/widget/food_tile.dart';
import 'package:delivery_app/widget/my_current_location.dart';
import 'package:delivery_app/widget/my_description_box.dart';
import 'package:delivery_app/widget/my_drawe.dart';
import 'package:delivery_app/widget/my_sliver_bar.dart';
import 'package:delivery_app/widget/tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  //tab bar controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length:FoodCategory.values.length, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out and return list food items to each category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //return list of food in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu){
    return FoodCategory.values.map((category) {

      //get category menu
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
          itemCount: categoryMenu.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            //get individual food
            final food = categoryMenu[index];

            //return food tile UI
            return FoodTile(
                food: food,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FoodPage(food:food),
                ),
                  ),
            ) ;
      } );

    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body:NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),

              //current location
                MyCurrentLocation(),

                //description box
               MyDescriptionBox(),

            ],
            ),
          ),
        ],
        body: Consumer<Restaurant>(builder: (context, restaurant, child)=>TabBarView(
          controller: _tabController,
          children: getFoodInThisCategory(restaurant.menu),
        ),
        ),
      ),


    );
  }
}
