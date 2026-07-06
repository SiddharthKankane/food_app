import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/login_screen.dart';
import 'package:food_app/screens/auth/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: const Key('auth_tab_controller'),
      length: 2,
      child: Scaffold(
        key: const Key('auth_scaffold'),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.amber],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "BringApp Cafe",
            key: Key('auth_header_title'),
            style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: "Lobster"),
          ),
          centerTitle: true,
          bottom: const TabBar(
            key: Key('auth_tab_bar'),
            tabs: [
              Tab(
                key: Key('login_tab'),
                icon: Icon(Icons.lock, color: Colors.white), 
                text: "Login"
              ),
              Tab(
                key: Key('register_tab'),
                icon: Icon(Icons.person, color: Colors.white), 
                text: "Register"
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.amber, Colors.cyan],
            ),
          ),
          child: const TabBarView(
            key: Key('auth_tab_view'),
            children: [
              LoginScreen(key: Key('login_screen_content')),
              RegisterScreen(key: Key('register_screen_content')),
            ]
          ),
        ),
      ),
    );
  }
}
