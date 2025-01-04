import 'package:flutter/material.dart';
import 'package:provider_2/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  //cart item state
  Map<String, CartItem> _items = {};
  //getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  // Get total number of items in the cart
  int get itemCount {
    return _items.length;
  }

  //add item
  void addItem(String productID, double price, String title) {
    if (_items.containsKey(productID)) {
      _items.update(
        productID,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      print("Add existing data");
    } else {
      _items.putIfAbsent(
        productID,
        () => CartItem(
          id: productID,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      print("Add new data");
    }
    notifyListeners();
  }
}
