import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/favorites_provider.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/screens/home/item_detail_screen.dart';
import 'package:food_app/screens/cart/cart_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<FavoritesProvider>(context);
    final userId = Provider.of<AuthProvider>(context, listen: false).userId;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.amber]),
          ),
        ),
        title: const Text("My Favorites", style: TextStyle(fontSize: 24)),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(
                cart.itemCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const CartScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: favs.favoriteItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 80, color: Colors.black.withValues(alpha: 0.3)),
                    const SizedBox(height: 20),
                    const Text(
                      "No favorites yet!",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: favs.favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favs.favoriteItems[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => ItemDetailScreen(item: item)),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      elevation: 2,
                      color: Colors.white.withValues(alpha: 0.9),
                      child: ListTile(
                        leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("\$${item.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Remove from Favorites
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.red),
                              onPressed: () {
                                if (userId != null) {
                                  favs.toggleFavorite(item, userId);
                                }
                              },
                            ),
                            // Add to Cart
                            IconButton(
                              icon: const Icon(Icons.add_circle, size: 30, color: Colors.amber),
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false)
                                    .addItem(item.id, item.price, item.title);
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item.title} added to cart!'),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
