import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/order_provider.dart';
import 'package:food_app/screens/orders/receipt_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final userId = Provider.of<AuthProvider>(context, listen: false).userId;
      if (userId != null) {
        setState(() => _isLoading = true);
        Provider.of<OrderProvider>(context, listen: false).fetchOrders(userId).then((_) {
          if (mounted) setState(() => _isLoading = false);
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    final orders = orderData.orders;

    return Scaffold(
      key: const Key('orders_scaffold'),
      backgroundColor: Colors.white,
      appBar: AppBar(
        key: const Key('orders_app_bar'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.amber]),
          ),
        ),
        title: const Text("My Orders", style: TextStyle(fontSize: 24)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              key: const Key('orders_cart_badge'),
              label: Text(
                cart.itemCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              child: ch,
            ),
            child: IconButton(
              key: const Key('orders_cart_button'),
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  key: Key('orders_loading_indicator'),
                  color: Colors.amber
                )
              )
            : orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long, 
                          key: const Key('orders_empty_icon'),
                          size: 80, 
                          color: Colors.black.withValues(alpha: 0.3)
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "No orders placed yet!",
                          key: Key('orders_empty_text'),
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    key: const Key('orders_list'),
                    padding: const EdgeInsets.all(15),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        key: ValueKey('order_card_${order.id}'),
                        elevation: 3,
                        color: Colors.white.withValues(alpha: 0.9),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                          title: Text("Order ${order.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(order.date),
                              const SizedBox(height: 5),
                              Text(
                                "\$${order.totalAmount.toStringAsFixed(2)} • ${order.status}", 
                                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (c) => ReceiptScreen(order: order)),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
