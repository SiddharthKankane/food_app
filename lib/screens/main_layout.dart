import 'package:flutter/material.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/profile/profile_screen.dart';
import 'package:food_app/screens/search/search_screen.dart';
import 'package:food_app/screens/orders/orders_screen.dart';
import 'package:food_app/screens/favorites/favorites_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(key: Key('home_screen')),
    const SearchScreen(key: Key('search_screen')),
    const FavoritesScreen(key: Key('favorites_screen')),
    const OrdersScreen(key: Key('orders_screen')),
    const ProfileScreen(key: Key('profile_screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('main_layout_scaffold'),
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        key: const Key('main_bottom_nav_bar'),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, key: Key('nav_home_icon')),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, key: Key('nav_search_icon')),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, key: Key('nav_favorites_icon')),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long, key: Key('nav_orders_icon')),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, key: Key('nav_profile_icon')),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
