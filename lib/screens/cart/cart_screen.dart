import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/order_provider.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/services/mock_api_service.dart';
import 'package:food_app/screens/tracking/tracking_screen.dart';
import 'package:food_app/screens/cart/checkout_options_screen.dart';
import 'package:food_app/screens/main_layout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();
    final cartItemKeys = cart.items.keys.toList();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.amber]),
          ),
        ),
        title: const Text("Your Cart"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate explicitly to Search screen (index 1)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => const MainLayout(initialIndex: 1)),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              if (cart.items.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Clear Cart?"),
                    content: const Text("Do you want to remove all items from the cart?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("No")),
                      TextButton(
                        onPressed: () {
                          cart.clear();
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              }
            },
          )
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
            Expanded(
              child: cart.items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/state.jpg',
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Your cart is empty!",
                            style: TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.black87
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Looks like you haven't added any food yet.",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, i) {
                        final item = cartItems[i];
                        final productId = cartItemKeys[i];
                        return Dismissible(
                          key: ValueKey(productId),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) => cart.removeItemCompletely(productId),
                          child: Card(
                            color: Colors.white.withValues(alpha: 0.9),
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: ListTile(
                              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                    onPressed: () => cart.removeSingleItem(productId),
                                  ),
                                  Text('${item.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                    onPressed: () => cart.addItem(productId, item.price, item.title),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            
            // Total Card (Only shown if cart is NOT empty)
            if (cart.items.isNotEmpty)
              Card(
                color: Colors.white.withValues(alpha: 0.9),
                margin: const EdgeInsets.all(15),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 20)),
                      Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.green),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => CheckoutOptionsScreen(
                                onOrderConfirmed: (method, note) {
                                  debugPrint("Payment: $method, Note: $note");
                                  _handleCheckout(context, cart);
                                },
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                        child: const Text('PROCEED', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),

            // Continue to Buy Button (ALWAYS visible at the bottom)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) => const MainLayout()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    "Continue to Buy",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  void _handleCheckout(BuildContext context, CartProvider cart) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('images/food-delivery.png', height: 150, fit: BoxFit.contain),
              const SizedBox(height: 20),
              const Text("Order Placed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 10),
              const Text("Sending your order to the restaurant...", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 20),
              const CircularProgressIndicator(color: Colors.amber),
            ],
          ),
        ),
      ),
    );

    bool success = await MockApiService.processCheckout(cart.totalAmount);

    if (context.mounted) Navigator.of(context).pop();

    if (success && context.mounted) {
      final userId = Provider.of<AuthProvider>(context, listen: false).userId;
      if (userId != null) {
        final List<OrderItem> orderItems = cart.items.values.map((i) => OrderItem(
          id: i.id,
          title: i.title,
          price: i.price,
          quantity: i.quantity,
        )).toList();
        
        if (context.mounted) {
          await Provider.of<OrderProvider>(context, listen: false).addOrder(userId, cart.totalAmount, orderItems);
        }
      }

      cart.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const TrackingScreen()));
    }
  }
}
