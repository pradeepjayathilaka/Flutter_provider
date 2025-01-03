import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_2/data/product_data.dart';
import 'package:provider_2/model/product_model.dart';
import 'package:provider_2/pages/cart_page.dart';
import 'package:provider_2/pages/favourite_page.dart';
import 'package:provider_2/providers/card_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter shop",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FAvouritePage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "fav_button",
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "cart_button",
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer(
              builder: (BuildContext context, CartProvider cartProvider,
                  Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // todo :fill this
                      Text(
                        "amount",
                      )
                    ],
                  ),
                  subtitle: Text(
                    "\$${product.price.toString()}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                      ),
                      IconButton(
                        onPressed: () {
                          CartProvider().addItem(
                            product.id,
                            product.price,
                            product.title,
                          );
                        },
                        icon: Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
