import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/screens/home/item_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Item> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = dummyMenu;
  }

  void _runSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = dummyMenu;
      } else {
        _filteredItems = dummyMenu
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('search_scaffold'),
      backgroundColor: Colors.white,
      appBar: AppBar(
        key: const Key('search_app_bar'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.amber],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "Search Food",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              key: const Key('search_cart_badge'),
              label: Text(
                cart.itemCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              child: ch,
            ),
            child: IconButton(
              key: const Key('search_cart_button'),
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
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.transparent,
              child: Image.asset(
                'images/login.png', 
                key: const Key('search_header_image'),
                fit: BoxFit.contain,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                key: const Key('search_text_field'),
                onChanged: (value) => _runSearch(value),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Search for burgers, pizza, etc...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.cyan),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            Expanded(
              child: _filteredItems.isEmpty
                  ? const Center(
                      child: Text(
                        "No food found!",
                        key: Key('search_empty_text'),
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    )
                  : ListView.builder(
                      key: const Key('search_results_list'),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return InkWell(
                          key: ValueKey('search_item_${item.id}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => ItemDetailScreen(item: item),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            color: Colors.white.withValues(alpha: 0.9),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                              trailing: Text("\$${item.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
