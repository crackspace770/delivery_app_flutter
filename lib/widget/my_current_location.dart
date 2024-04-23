import 'package:delivery_app/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
  final textController = TextEditingController();

  void openLocationSearchBox(BuildContext context) {
    showDialog
      (context: context,
        builder: (context) =>AlertDialog(
          title: Text("Your Location"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter Address.."),
          ),
          actions: [
            //cancel
            MaterialButton(
            onPressed:() {
        Navigator.pop(context);
        textController.clear();
        } ,
            child: Text('Cancel'),

            ),

            //save
            MaterialButton(

              onPressed:(){
                String newAddress = textController.text;
                context.read<Restaurant>().updateDeliveryAddress(newAddress);
                Navigator.pop(context);
                textController.clear();

                },
              child: Text('Save'),

            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver Now!",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold
          ),
          ),
          GestureDetector(
            onTap: () =>openLocationSearchBox(context),
            child:
            Row(
              children: [
              //address
              Consumer<Restaurant>(builder: (context,restaurant, child) =>Text(
                  restaurant.deliveryAddress)
              ),

              //dropdown menu
              Icon(Icons.keyboard_arrow_down_rounded)
            ],),
          )
        ],
      ),
    );
  }
}
