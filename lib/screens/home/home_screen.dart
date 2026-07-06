import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/favorites_provider.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/screens/home/item_detail_screen.dart';
import 'package:food_app/screens/cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Burgers', 'Pizza', 'Healthy', 'Drinks'];

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).userId;

    List<Item> filteredMenu = _selectedCategory == 'All'
        ? dummyMenu
        : dummyMenu.where((item) => item.category == _selectedCategory).toList();

    return Scaffold(
      key: const Key('home_scaffold'),
      backgroundColor: Colors.white,
      appBar: AppBar(
        key: const Key('home_app_bar'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.amber]),
          ),
        ),
        title: const Text("BringApp Cafe", style: TextStyle(fontSize: 28)),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              key: const Key('home_cart_badge'),
              label: Text(cart.itemCount.toString(), style: const TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
              child: ch,
            ),
            child: Semantics(
              identifier: "home_cart_button",
              child: IconButton(
                key: const Key('home_cart_button'),
                icon: const Icon(Icons.shopping_cart, color: Colors.black, size: 28),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const CartScreen()));
                },
              ),
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
        child: Column(
          children: [
            Container(
              key: const Key('home_banner'),
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/restaurant.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(
                  child: Text(
                    "BringApp Cafe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            
            _buildCategoryList(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: [
                  Image.asset('images/menu.png', height: 25, width: 25),
                  const SizedBox(width: 10),
                  Text(
                    "$_selectedCategory Menu", 
                    key: ValueKey('home_menu_header_$_selectedCategory'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: filteredMenu.isEmpty
                  ? const Center(
                      child: Text(
                        "No items in this category yet!",
                        key: Key('home_empty_menu_text'),
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      key: const Key('home_food_list'),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: filteredMenu.length,
                      itemBuilder: (context, index) {
                        final item = filteredMenu[index];
                        return _buildMenuItemCard(context, item, userId);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Container(
      key: const Key('home_category_list_container'),
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        key: const Key('home_category_list'),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return GestureDetector(
            key: ValueKey('category_chip_$category'),
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber : (Colors.grey[200] ?? Colors.grey).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
                    : [],
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItemCard(BuildContext context, Item item, String? userId) {
    return InkWell(
      key: ValueKey('food_card_${item.id}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => ItemDetailScreen(item: item)),
        );
      },
      child: Card(
        elevation: 2,
        color: Colors.white.withValues(alpha: 0.9),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(item.imageUrl, width: 60, height: 60),
          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("\$${item.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<FavoritesProvider>(
                builder: (context, favs, _) => Semantics(
                  identifier: "fav_button_${item.id}",
                  child: IconButton(
                    key: ValueKey('fav_button_${item.id}'),
                    icon: Icon(
                      favs.isFavorite(item) ? Icons.favorite : Icons.favorite_border,
                      color: favs.isFavorite(item) ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      if (userId != null) {
                        favs.toggleFavorite(item, userId);
                      }
                    },
                  ),
                ),
              ),
              Semantics(
                identifier: "add_to_cart_button_${item.id}",
                child: IconButton(
                  key: ValueKey('add_to_cart_button_${item.id}'),
                  icon: const Icon(Icons.add_circle, size: 35, color: Colors.amber),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(item.id, item.price, item.title);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          key: ValueKey('snackbar_added_${item.id}'),
                          content: Text('${item.title} added!'), 
                          duration: const Duration(seconds: 1)
                        )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
