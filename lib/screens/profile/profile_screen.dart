import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/screens/auth/auth_screen.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/favorites_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Provider.of<FavoritesProvider>(context, listen: false).clearFavorites();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => const AuthScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: const Key('profile_scaffold'),
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
              CircleAvatar(
                key: const Key('profile_avatar'),
                radius: 60,
                backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                backgroundImage: const AssetImage("images/user.png"),
              ),
              const SizedBox(height: 20),

              Text(
                userData.username ?? "Guest User",
                key: const Key('profile_username'),
                style: const TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                userData.email ?? "no-email@testkraft.com",
                key: const Key('profile_email'),
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  key: const Key('profile_info_card'),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.white.withValues(alpha: 0.9),
                  child: Column(
                    children: [
                      ListTile(
                        key: const Key('profile_address_tile'),
                        leading: const Icon(Icons.location_on, color: Colors.cyan),
                        title: const Text("Delivery Address"),
                        subtitle: Text(userData.address ?? "No address provided"),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        key: const Key('profile_phone_tile'),
                        leading: const Icon(Icons.phone, color: Colors.green),
                        title: const Text("Phone Number"),
                        subtitle: Text(userData.phone ?? "No phone provided"),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        key: const Key('profile_logout_tile'),
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
