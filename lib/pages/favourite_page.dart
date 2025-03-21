import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_2/data/product_data.dart';
import 'package:provider_2/model/product_model.dart';
import 'package:provider_2/providers/favourite_provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite Page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<FavouriteProvider>(
          builder: (BuildContext context, FavouriteProvider, Widget? child) {
        final favItems = FavouriteProvider.favorites.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();

        if (favItems.isEmpty) {
          return Center(
            child: Text("No Favourite Items"),
          );
        }
        return ListView.builder(
          itemCount: favItems.length,
          itemBuilder: (context, index) {
            final productId = favItems[index];
            final Product product = ProductData()
                .products
                .firstWhere((Product) => Product.id == productId);

            return Card(
              child: ListTile(
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
                trailing: IconButton(
                  onPressed: () {
                    FavouriteProvider.toggleFavourite(product.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Removed from favourites!"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
