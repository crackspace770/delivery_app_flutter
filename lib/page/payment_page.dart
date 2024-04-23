
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'delivery_progress_page.dart';

class PaymentPage extends StatefulWidget {


  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName ='';
  String cvvCode = '';
  bool isCvvFocused = false;

  //user pay
  void userTappedPay(){
    if(formKey.currentState!.validate()) {
      //only show dialog if form is valid
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
           title: Text("Confirm Payment"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Card Number: $cardNumber"),
                  Text("Expiry Date: $expiryDate"),
                  Text("Card Holder Name: $cardHolderName"),
                  Text("VV: $cvvCode"),
                ],
              ),
            ),
            actions: [
              //Confirm
              TextButton(
                  onPressed: ()  {
                  Navigator.pop(context);
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const DeliveryProgressPage()
                ),
              );

            },


                  child: const Text("Yes")
              ),
              //cancel
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("No")
              ),
            ],
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          //credit cart
          CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (p0) {},
          ),

          //credit card form
          CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });

              },
              formKey: formKey
          ),

          const Spacer(),

          GestureDetector(
            onTap: userTappedPay ,
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
                      child: Text('Checkout',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary
                        ),
                      )),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
