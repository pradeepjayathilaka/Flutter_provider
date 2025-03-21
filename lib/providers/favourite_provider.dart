import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  //state
  final Map<String, bool> _favourite = {};

  //getter
  Map<String, bool> get favorites => _favourite;

  //toggle favourite
  void toggleFavourite(String productId) {
    if (_favourite.containsKey(productId)) {
      _favourite[productId] = !_favourite[productId]!;
    } else {
      _favourite[productId] = true;
    }
    notifyListeners();
  }

  //method to check wether a fav or not
  bool isFavourite(String productId) {
    return _favourite[productId] ?? false;
  }
}
