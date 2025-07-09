import 'dart:convert';

import 'package:cafe_app/pages/app_constant.dart';
import 'package:cafe_app/services/database.dart';
import 'package:cafe_app/services/shared_pref.dart';
import 'package:cafe_app/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;


class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController amountController= new TextEditingController();

  getthesharedpref() async{
    wallet= await SharedPreferenceHelper().getUserWallet();
    id= await SharedPreferenceHelper().getUserId();
    setState(() {
      
    });
  }

ontheload()async{
  await getthesharedpref();
  setState(() {
    
  });
}

 @override
  void initState() {
    ontheload();
    super.initState();
  }



Map<String, dynamic>? paymentIntent;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet==null? CircularProgressIndicator(): Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(child: Text("Wallet", style: AppWidget.HeadlineTextFieldStyle(),),),
                ),
            ),
            SizedBox(height: 30,),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFFE9E2E2)),
              child: Row(children: [
                Image.asset("assets/images/wallet.png", height: 60, width: 60, fit: BoxFit.cover,),
                SizedBox(width: 40,),
                Column(
                  children: [
                    Text("Your wallet", style: AppWidget.SemiBoldTextFieldStyle(),),
                    SizedBox(height: 5,),
                    Text("RM"+ wallet!, style: AppWidget.boldTextFieldStyle(),),
                  ],
                )
              ],),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Money", style: AppWidget.SemiBoldTextFieldStyle(),),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 40,),
                GestureDetector(
                  onTap: (){
                    makePayment('10');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("RM"+ "10", style: AppWidget.SemiBoldTextFieldStyle(),),
                  ),
                ),
                SizedBox(width: 25,),

                GestureDetector(
                   onTap: (){
                    makePayment('50');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("RM"+ "50", style: AppWidget.SemiBoldTextFieldStyle(),),
                  ),
                ),
                SizedBox(width: 25,),

                GestureDetector(
                   onTap: (){
                    makePayment('100');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("RM"+ "100", style: AppWidget.SemiBoldTextFieldStyle(),),
                  ),
                ),
                SizedBox(width: 25,),
                GestureDetector(
                   onTap: (){
                    makePayment('200');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("RM"+ "200", style: AppWidget.SemiBoldTextFieldStyle(),),
                  ),
                )
              ],
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                openEdit();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF008080), borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text("Add Money", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Poppins", fontWeight: FontWeight.bold),),),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> makePayment(String amount) async {
  try {
    // Add more detailed logging
    print('Starting payment for amount: $amount');

    // Create Payment Intent
    paymentIntent = await createPaymentIntent(amount, 'MYR');
    
    if (paymentIntent == null) {
      print('Payment intent creation failed');
      return;
    }

    // Verify client secret exists
    if (!paymentIntent!.containsKey('client_secret')) {
      print('Client secret is missing');
      return;
    }

    // Initialize Payment Sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        merchantDisplayName: 'Waheeda',
        style: ThemeMode.light, // Consider using light mode
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'MY', // Malaysia country code
          currencyCode: 'MYR',
          testEnv: true, // Set to false in production
        ),
      ),
    );

    // Display Payment Sheet
    await displayPaymentSheet(amount);

  } catch (e, stackTrace) {
    print('Payment Initialization Error: $e');
    print('Stack Trace: $stackTrace');

    // Show user-friendly error dialog
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text('Payment Error'),
        content: Text('Unable to process payment: $e'),
      )
    );
  }
}


  displayPaymentSheet(String amount)async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value)async {
        add=int.parse(wallet!)+int.parse(amount);
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().UpdateUserWallet(id!,add.toString());
        showDialog(context: context, builder: (_)=>AlertDialog(
          content: Column(children: [
            Icon(Icons.check_circle, color: Colors.green,), Text("Payment Successful")
          ],),
        ));
        await getthesharedpref();

        
        paymentIntent=null;

      }).onError((error, stackTrace){
        print('Error is :---> $error $stackTrace');
      });
    }on StripeException catch(e){
      print('Error is:---> $e');
      showDialog(context: context, builder: (_)=> const AlertDialog(
        content: Text("Cancelled"),
      ));
    }catch(e){
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Payment Intent Creation Failed: ${response.body}');
      throw Exception('Failed to create payment intent');
    }
  } catch (err) {
    print('Error creating payment intent: ${err.toString()}');
    rethrow;
  }
}

  calculateAmount(String amount){
    final calculatedAmount=(int.parse(amount)*100);

    return calculatedAmount.toString();
  }

  Future openEdit()=> showDialog(context: context, builder: (context)=>AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel),),
                  SizedBox(width: 60,),
                  Center(
                    child: Text("Add Money", style: TextStyle(color: Color(0xFF008080), fontWeight: FontWeight.bold),),
                  )
              ],
            ),
            SizedBox(height: 20,),
            Text("Amount"),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 2,),
                borderRadius: BorderRadius.circular(10),
              ),

              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Amount'
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  makePayment(amountController.text);
                },
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Color(0xFF008080), borderRadius: BorderRadius.circular(10)), child: Center(child: Text("Pay", style: TextStyle(color: Colors.white),))
                ),
              ),
            )
          ],
        ),
      ),
    ),
  ));
}