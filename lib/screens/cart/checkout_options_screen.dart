import 'package:flutter/material.dart';

class CheckoutOptionsScreen extends StatefulWidget {
  final Function(String, String) onOrderConfirmed;

  const CheckoutOptionsScreen({super.key, required this.onOrderConfirmed});

  @override
  State<CheckoutOptionsScreen> createState() => _CheckoutOptionsScreenState();
}

class _CheckoutOptionsScreenState extends State<CheckoutOptionsScreen> {
  String _paymentMethod = "Cash on Delivery";
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.amber]),
          ),
        ),
        title: const Text("Checkout Details"),
        centerTitle: true,
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
            children: [
              // Delivery Instructions
              TextField(
                controller: _noteController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Delivery Instructions",
                  labelStyle: const TextStyle(color: Colors.black87),
                  hintText: "e.g., Gate code is 1234",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.9),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              
              // Payment Method Selection
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'TimesNewRoman'),
                    items: ["Cash on Delivery", "Credit Card", "UPI"].map((m) {
                      return DropdownMenuItem(value: m, child: Text(m));
                    }).toList(),
                    onChanged: (val) => setState(() => _paymentMethod = val!),
                    decoration: const InputDecoration(
                      labelText: "Payment Method",
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onOrderConfirmed(_paymentMethod, _noteController.text);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  child: const Text("Confirm & Place Order", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
