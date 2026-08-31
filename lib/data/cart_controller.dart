import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get total => product.price * quantity;
}

class CartController extends ChangeNotifier {
  CartController._();
  static final CartController instance = CartController._();

  final List<CartItem> items = [];

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  double get total => items.fold(0, (sum, item) => sum + item.total);

  void add(Product product, {int quantity = 1}) {
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      items[index].quantity += quantity;
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void increase(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrease(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    items.remove(item);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}
