
import 'package:delivery_app/model/restaurant.dart';
import 'package:delivery_app/service/firestore.dart';
import 'package:delivery_app/widget/receipt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {

  //get access to database
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

    //if we get o this page, submit order to firestore db
    String receipt = context.read<Restaurant>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery in progress"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _builBottomNavBar(context),
      body: Column(
        children: [
          MyReceipt(),
        ],
      ),
    );
  }

  //custom bottom navbar = message/call delivery/
  Widget _builBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40)
        )
      ),
      child: Row(
        children: [
          //profile pic of driver
          Container(
            decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            shape: BoxShape.circle
          ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ),

          SizedBox(height: 10),
          //driver detail
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mike Truck",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary
              ),
              ),

              Text("Driver",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
              )
            ],
          ),

          const Spacer(),

          Row(children: [
            //message button
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.message,
                color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            //call button
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.call,
                color: Colors.green,
                ),
              ),
            ),

          ],
          ),

        ],
      ),
    );
  }
}
