import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/screens/main_layout.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int _currentStatus = 0;
  Timer? _mockTimer;

  @override
  void initState() {
    super.initState();
    _mockTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentStatus < 3) {
        if (mounted) {
          setState(() {
            _currentStatus++;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('tracking_scaffold'),
      backgroundColor: Colors.white,
      appBar: AppBar(
        key: const Key('tracking_app_bar'),
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
          "Track Order",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
              key: const Key('tracking_visual_container'),
              height: 250,
              width: double.infinity,
              color: Colors.grey[200]!.withValues(alpha: 0.5),
              child: _getVisualForStatus(),
            ),

            const SizedBox(height: 20),

            Text(
              _getStatusText(),
              key: ValueKey('tracking_status_text_$_currentStatus'),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildTrackerStep(0, "Order Placed", Icons.receipt_long, "We have received your order."),
                  _buildTrackerStep(1, "Preparing", Icons.soup_kitchen, "The kitchen is making your food."),
                  _buildTrackerStep(2, "On the Way", Icons.delivery_dining, "Rider is heading to your location."),
                  _buildTrackerStep(3, "Delivered", Icons.home, "Enjoy your meal!"),
                ],
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  key: const Key('tracking_back_home_button'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) => const MainLayout()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _getVisualForStatus() {
    if (_currentStatus == 1) {
      return Image.asset(
        'images/food-delivery.png',
        key: const Key('tracking_prep_image'),
        fit: BoxFit.contain, 
      );
    } else if (_currentStatus == 2) {
      return Image.asset(
        'images/delivery.jpg',
        key: const Key('tracking_delivery_image'),
        fit: BoxFit.cover,
      );
    } else if (_currentStatus == 3) {
      return Image.asset(
        'images/delivered.jpg',
        key: const Key('tracking_delivered_image'),
        fit: BoxFit.cover,
      );
    } else {
      return const Stack(
        key: Key('tracking_searching_visual'),
        alignment: Alignment.center,
        children: [
          Icon(Icons.map, size: 100, color: Colors.grey),
          Positioned(
            bottom: 20,
            child: Text(
              "Searching for Rider...",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),
          Positioned(
            left: 100,
            top: 150,
            child: Icon(Icons.location_pin, size: 50, color: Colors.blue),
          ),
        ],
      );
    }
  }

  String _getStatusText() {
    switch (_currentStatus) {
      case 0: return "Awaiting Confirmation";
      case 1: return "Preparing your food";
      case 2: return "Out for Delivery";
      case 3: return "Order Delivered!";
      default: return "Processing";
    }
  }

  Widget _buildTrackerStep(int stepIndex, String title, IconData icon, String subtitle) {
    bool isCompleted = _currentStatus >= stepIndex;
    bool isCurrent = _currentStatus == stepIndex;

    return Row(
      key: ValueKey('tracker_step_$stepIndex'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: isCompleted ? Colors.green : Colors.grey[300],
              child: Icon(icon, color: isCompleted ? Colors.white : Colors.grey[600]),
            ),
            if (stepIndex < 3)
              Container(
                height: 40,
                width: 3,
                color: isCompleted && !isCurrent ? Colors.green : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isCompleted ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
