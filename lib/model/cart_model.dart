class CartItem {
  final Map<String, dynamic> product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => double.parse(product['price'].replaceAll('RM', '')) * quantity;
}

class CartModel {
  static List<CartItem> items = [];

  static void addToCart(Map<String, dynamic> product, int quantity) {
    // Check if product already exists in cart
    for (var item in items) {
      if (item.product['name'] == product['name']) {
        item.quantity += quantity;
        return;
      }
    }
    
    // If product not in cart, add new item
    items.add(CartItem(product: product, quantity: quantity));
  }

  static void removeFromCart(Map<String, dynamic> product) {
    items.removeWhere((item) => item.product['name'] == product['name']);
  }

  static double getTotalPrice() {
    return items.fold(0, (total, item) => total + item.totalPrice);
  }
}
