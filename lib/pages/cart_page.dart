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
                    return Container(
                      color: Color.fromARGB(107, 236, 189, 87),
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(cartItem.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.id),
                            Text("\$${cartItem.price}x${cartItem.quantity}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.removeSingleItem(cartItem.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("One Item Removed"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.remove,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(cartItem.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Remove from Cart"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.remove_shopping_cart,
                              ),
                            )
                          ],
                        ),
                      ),
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
