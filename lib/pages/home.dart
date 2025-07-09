import 'package:cafe_app/pages/cart_page.dart';
import 'package:cafe_app/pages/details.dart';
import 'package:cafe_app/widget/widget_support.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool coffee = false, tea = false, smoothie = false, cake = false;

  final List<Map<String, dynamic>> products = [
    //coffee
    {
    'name': 'Americano',
    'description': 'Strong black coffee',
    'price': 'RM13',
    'image': 'assets/images/americano.jpg',
    'category': 'coffee'
  },
  {
    'name': 'Cappuccino',
    'description': 'Rich creamy coffee',
    'price': 'RM18',
    'image': 'assets/images/cappucino.png',
    'category': 'coffee'
  },
  {
    'name': 'Latte',
    'description': 'Smooth milky coffee',
    'price': 'RM16',
    'image': 'assets/images/latte.png',
    'category': 'coffee'
  },
  {
    'name': 'Macchiato',
    'description': 'Espresso with foam',
    'price': 'RM16',
    'image': 'assets/images/macchiato.png',
    'category': 'coffee'
  },

  // tea
  {
    'name': 'Green Tea',
    'description': 'Refreshing healthy tea',
    'price': 'RM10',
    'image': 'assets/images/greentea.png',
    'category': 'tea'
  },
  {
    'name': 'Jasmine Tea',
    'description': 'Aromatic floral tea',
    'price': 'RM10',
    'image': 'assets/images/jasminetea.jpg',
    'category': 'tea'
  },
  {
    'name': 'Chamomile Tea',
    'description': 'Soothing herbal tea',
    'price': 'RM10',
    'image': 'assets/images/chamomiletea.jpg',
    'category': 'tea'
  },
  {
    'name': 'Oolong Tea',
    'description': 'Rich roasted tea',
    'price': 'RM18',
    'image': 'assets/images/oolongtea.jpg',
    'category': 'tea'
  },

  // smoothie
  {
    'name': 'Tropical Punch',
    'description': 'Fruity tropical blend',
    'price': 'RM15',
    'image': 'assets/images/tropicalpunch.png',
    'category': 'smoothie'
  },
  {
    'name': 'Chocolate Oreo',
    'description': 'Rich chocolate treat',
    'price': 'RM14',
    'image': 'assets/images/chocoreo.jpg',
    'category': 'smoothie'
  },
  {
    'name': 'Mango Tango',
    'description': 'Refreshing mango delight',
    'price': 'RM13',
    'image': 'assets/images/mangotango.png',
    'category': 'smoothie'
  },
  {
    'name': 'Peach Perfection',
    'description': 'Sweet peach smoothie',
    'price': 'RM18',
    'image': 'assets/images/peachperfection.jpg',
    'category': 'smoothie'
  },

  // cake
  {
    'name': 'Chocolate Cake',
    'description': 'Rich chocolate indulgence',
    'price': 'RM8',
    'image': 'assets/images/chocolate.png',
    'category': 'cake'
  },
  {
    'name': 'Cheese Cake',
    'description': 'Creamy cheesy delight',
    'price': 'RM9',
    'image': 'assets/images/cheese.jpg',
    'category': 'cake'
  },
  {
    'name': 'Brownie',
    'description': 'Fudgy chocolate squares',
    'price': 'RM5',
    'image': 'assets/images/brownie.png',
    'category': 'cake'
  },
  {
    'name': 'Cupcake',
    'description': 'Mini sweet treat',
    'price': 'RM4',
    'image': 'assets/images/cupcake.png',
    'category': 'cake'
  }

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome Back!",
                  style: AppWidget.boldTextFieldStyle()
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Icon(Icons.shopping_cart, color: Colors.white),
                )

              ],
            ),

            SizedBox(height: 8.0),
            Text(
              "Brew & Bite",
              style: AppWidget.HeadlineTextFieldStyle()
            ),
            Text(
              "Cafe and Treats",
              style: AppWidget.LightTextFieldStyle()
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: showItem(),
            ),

            SizedBox(height: 1.2),
            Expanded(
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10
    ),
    itemCount: getFilteredProducts().length, // Change this line
    itemBuilder: (context, index) {
      final filteredProducts = getFilteredProducts(); // Add this line
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Details(product: filteredProducts[index]), // Change this line
          ));
        },
        child: Container(
          margin: EdgeInsets.all(4),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      filteredProducts[index]['image'], // Change this line
                      height: 125, 
                      width: 125, 
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    filteredProducts[index]['name'], // Change this line
                    style: AppWidget.SemiBoldTextFieldStyle(),
                  ),
                  SizedBox(height: 1.5),
                  Text(
                    filteredProducts[index]['description'], // Change this line
                    style: AppWidget.LightTextFieldStyle(),
                  ),
                  SizedBox(height: 1.5),
                  Text(
                    filteredProducts[index]['price'], // Change this line
                    style: AppWidget.SemiBoldTextFieldStyle(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ),
)

          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getFilteredProducts() {
    if (coffee) {
      return products.where((product) => product['category'] == 'coffee').toList();
    } else if (tea) {
      return products.where((product) => product['category'] == 'tea').toList();
    } else if (smoothie) {
      return products.where((product) => product['category'] == 'smoothie').toList();
    } else if (cake) {
      return products.where((product) => product['category'] == 'cake').toList();
    }
    return products;
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            coffee = true;
            tea = false;
            smoothie = false;
            cake = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: coffee ? Colors.black : Colors.white, 
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/coffee.png", 
                height: 40, 
                width: 40, 
                fit: BoxFit.cover, 
                color: coffee ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            coffee = false;
            tea = true;
            smoothie = false;
            cake = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: tea ? Colors.black : Colors.white, 
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/tea.png", 
                height: 40, 
                width: 40, 
                fit: BoxFit.cover, 
                color: tea ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            coffee = false;
            tea = false;
            smoothie = true;
            cake = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: smoothie ? Colors.black : Colors.white, 
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/smoothie.png", 
                height: 40, 
                width: 40, 
                fit: BoxFit.cover, 
                color: smoothie ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            coffee = false;
            tea = false;
            smoothie = false;
            cake = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: cake ? Colors.black : Colors.white, 
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/cake.png", 
                height: 40, 
                width: 40, 
                fit: BoxFit.cover, 
                color: cake ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
