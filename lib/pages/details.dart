
import 'package:cafe_app/model/cart_model.dart';
import 'package:cafe_app/pages/cart_page.dart';
import 'package:cafe_app/widget/widget_support.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Map<String, dynamic> product;
  
  const Details({Key? key, required this.product}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined, 
                color: Colors.black,
              ),
            ),
            Image.asset(
              widget.product['image'], 
              width: MediaQuery.of(context).size.width, 
              height: MediaQuery.of(context).size.height/3, 
              fit: BoxFit.fill,
            ),
            SizedBox(height: 15),
            
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product['name'], 
                      style: AppWidget.HeadlineTextFieldStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a; 
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black, 
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  a.toString(), 
                  style: AppWidget.SemiBoldTextFieldStyle(),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    ++a;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black, 
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            Text(
              widget.product['description'], 
              style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Delivery Time", 
                  style: AppWidget.boldTextFieldStyle(),
                ),
                SizedBox(width: 5),
                Icon(Icons.alarm, color: Colors.black54),
                SizedBox(width: 5),
                Text(
                  "30 min", 
                  style: AppWidget.SemiBoldTextFieldStyle(),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price", 
                        style: AppWidget.SemiBoldTextFieldStyle(),
                      ),
                      Text(
                        widget.product['price'], 
                        style: AppWidget.HeadlineTextFieldStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add to cart functionality
                      CartModel.addToCart(widget.product, a);
                      
                      // Show SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: Text('${widget.product['name']} added to cart', style: TextStyle(fontSize: 18),),
                          duration: Duration(seconds: 2),
                          
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.7,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black, 
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add to cart", 
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 18, 
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 