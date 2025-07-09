import 'package:cafe_app/model/cart_model.dart';
import 'package:cafe_app/services/database.dart';
import 'package:cafe_app/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/widget/widget_support.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(child: Text("Your Cart", style: AppWidget.HeadlineTextFieldStyle(),),),
                ),
            ),
            
            SizedBox(height: 20),
            Expanded(
              child: CartModel.items.isEmpty 
              ? Center(
                  child: Text(
                    'Your cart is empty', 
                    style: AppWidget.SemiBoldTextFieldStyle(),
                  ),
                )
              : ListView.builder(
                itemCount: CartModel.items.length,
                itemBuilder: (context, index) {
                  var cartItem = CartModel.items[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Image.asset(
                              cartItem.product['image'], 
                              width: 80, 
                              height: 80, 
                              fit: BoxFit.cover
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.product['name'], 
                                    style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.bold), 
                                  ),
                                  Text(
                                    'Price: ${cartItem.product['price']}', 
                                    style: TextStyle(color:Colors.grey, fontSize: 17, fontWeight: FontWeight.w600), 
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (cartItem.quantity > 1) {
                                        cartItem.quantity--;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Icon(Icons.remove, color: Colors.white, size: 24),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${cartItem.quantity}', 
                                  style: AppWidget.SemiBoldTextFieldStyle(),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cartItem.quantity++;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Icon(Icons.add, color: Colors.white, size: 24),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          title: Row(
                                            children: [
                                              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                                              SizedBox(width: 10),
                                              Text(
                                                'Delete Item',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                            'Are you sure you want to delete this item?',
                                            style: TextStyle(fontSize: 18, color: Colors.black54),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.black54,
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                              ),
                                              child: Text('Cancel', style: TextStyle(fontSize: 18)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              ),
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(fontSize: 18, color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  CartModel.removeFromCart(cartItem.product);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  },
                                  child: Icon(Icons.delete, color: Colors.red, size: 26),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price:',
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    'RM ${calculateTotalPrice().toStringAsFixed(2)}', 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
  padding: const EdgeInsets.only(bottom: 40),
  child: GestureDetector(
    onTap: CartModel.items.isEmpty 
      ? null 
      : () async {
          double totalPrice = calculateTotalPrice();
          String? wallet = await SharedPreferenceHelper().getUserWallet();
          String? userId = await SharedPreferenceHelper().getUserId();
          double walletBalance = double.parse(wallet ?? "0");

          if (walletBalance >= totalPrice) {
            // Deduct the total price from wallet
            double updatedWalletBalance = walletBalance - totalPrice;

            // Update shared preferences and database
            await SharedPreferenceHelper().saveUserWallet(updatedWalletBalance.toString());
            await DatabaseMethods().UpdateUserWallet(userId!, updatedWalletBalance.toString());

            // Clear the cart
            setState(() {
              CartModel.items.clear();
            });

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Checkout successful! Wallet updated.', style: TextStyle(fontSize: 18)),
              ),
            );
          } else {
            // Insufficient funds
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Insufficient wallet balance!', style: TextStyle(fontSize: 18)),
              ),
            );
          }
        },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black, 
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20, 
            fontFamily: "Poppins", 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    return CartModel.items.fold(0, (total, item) {
      double price = double.parse(item.product['price'].replaceAll('RM', ''));
      return total + (price * item.quantity);
    });
  }
}