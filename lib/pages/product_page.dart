import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_2/data/product_data.dart';
import 'package:provider_2/model/product_model.dart';
import 'package:provider_2/pages/cart_page.dart';
import 'package:provider_2/pages/favourite_page.dart';
import 'package:provider_2/providers/card_provider.dart';
import 'package:provider_2/providers/favourite_provider.dart';

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
                  builder: (context) => FavouritePage(),
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
            child: Consumer2<CartProvider, FavouriteProvider>(
              builder: (BuildContext context, CartProvider cartProvider,
                  FavouriteProvider favouriteProvider, Widget? child) {
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
                        width: 50,
                      ),
                      Text(
                        cartProvider.items.containsKey(product.id)
                            ? cartProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                        onPressed: () {
                          favouriteProvider.toggleFavourite(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  favouriteProvider.isFavourite(product.id)
                                      ? "Added to Favourite"
                                      : "Removed from Favourite!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          favouriteProvider.isFavourite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favouriteProvider.isFavourite(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItem(
                            product.id,
                            product.price,
                            product.title,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added to Cart!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
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
