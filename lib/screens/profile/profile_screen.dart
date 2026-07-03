import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/screens/auth/auth_screen.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/favorites_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context) {
    // 1. Clear session
    Provider.of<AuthProvider>(context, listen: false).logout();
    
    // 2. Clear favorites from memory
    Provider.of<FavoritesProvider>(context, listen: false).clearFavorites();

    // 3. Navigate back to the Auth Screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => const AuthScreen()),
      (route) => false, // This clears the navigation stack entirely
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Profile Picture
              const CircleAvatar(
                radius: 60,
                backgroundColor: Color.fromARGB(255, 238, 238, 238),
                backgroundImage: AssetImage("images/user.png"),
              ),
              const SizedBox(height: 20),

              // DYNAMIC: Actual User Details
              Text(
                userData.username ?? "Guest User",
                style: const TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                userData.email ?? "no-email@testkraft.com",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Account Options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.white.withValues(alpha: 0.9),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.cyan),
                        title: const Text("Delivery Address"),
                        subtitle: Text(userData.address ?? "No address provided"),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.phone, color: Colors.green),
                        title: const Text("Phone Number"),
                        subtitle: Text(userData.phone ?? "No phone provided"),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text("Logout"),
                        onTap: () => _handleLogout(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
