import 'package:cafe_app/pages/cart_page.dart';
import 'package:cafe_app/pages/home.dart';
import 'package:cafe_app/pages/order.dart';
import 'package:cafe_app/pages/profile.dart';
import 'package:cafe_app/pages/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex=0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late CartPage cartPage;
  late Wallet wallet;

  @override
  void initState() {
    homepage=Home();
    cartPage = CartPage();
    profile=Profile();
    wallet=Wallet();
    pages=[homepage, cartPage, wallet, profile];
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 65,
            backgroundColor: Colors.white,
            color: Colors.black,
            animationDuration: Duration(milliseconds: 400),
            onTap: (int index){
              setState(() {
                currentTabIndex=index;
              });
            },
            items: [
            Icon(Icons.home_outlined, 
              color: Colors.white,
            ),
            Icon(Icons.shopping_cart_outlined, 
              color: Colors.white,
            ),
            Icon(Icons.wallet_outlined, 
              color: Colors.white,
            ),
            Icon(Icons.person_outlined, 
              color: Colors.white,
            ),
          ],
        ),
        body: pages[currentTabIndex],
      );
  }
}