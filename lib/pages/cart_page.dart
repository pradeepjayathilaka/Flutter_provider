import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_2/providers/card_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart Page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items.values.toList()[index];
                    return ListTile(
                      title: Text(cartItem.title),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
