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
    }
    notifyListeners();
  }

  //remove from cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //remove single item form cart
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  //clear
  void clearAll() {
    _items = {};
    notifyListeners();
  }

  //calculate total
  double get totalamount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    notifyListeners();
    return total.toDouble();
  } 
}
