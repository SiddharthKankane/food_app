import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/providers/cart_provider.dart';

class ReceiptScreen extends StatelessWidget {
  final PastOrder order;

  const ReceiptScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.amber]),
          ),
        ),
        title: const Text("Receipt"),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('images/delivered.jpg', height: 120),
              ),
              const SizedBox(height: 20),
              Text("Order #${order.id}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(order.date, style: const TextStyle(color: Colors.black54)),
              const Divider(height: 40, thickness: 2, color: Colors.black26),
              
              // List out the items purchased
              Expanded(
                child: ListView.builder(
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item.quantity}x ${item.title}", style: const TextStyle(fontSize: 16)),
                          Text("\$${(item.price * item.quantity).toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              const Divider(thickness: 2, color: Colors.black26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Paid", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("\$${order.totalAmount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
              const SizedBox(height: 30),
              
              // The Magic "Reorder" Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final cart = Provider.of<CartProvider>(context, listen: false);
                    // Loop through past items and add them to the current cart
                    for (var item in order.items) {
                      for (int i = 0; i < item.quantity; i++) {
                        cart.addItem(item.id, item.price, item.title);
                      }
                    }
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Items added to your cart!'), backgroundColor: Colors.green),
                    );
                    Navigator.pop(context); // Go back to the orders list
                  },
                  icon: const Icon(Icons.refresh, color: Colors.black),
                  label: const Text("Reorder These Items", style: TextStyle(fontSize: 18, color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
