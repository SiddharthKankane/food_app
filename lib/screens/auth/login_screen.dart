import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/widgets/custom_text_field.dart';
import 'package:food_app/screens/main_layout.dart';
import 'package:food_app/services/auth_service.dart';
import 'package:food_app/screens/auth/register_screen.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/favorites_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  void _attemptLogin() async {
    setState(() => _isLoading = true);

    final userData = await AuthService.login(
      _userController.text, 
      _passController.text
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (userData != null) {
      final userId = userData['id'].toString();
      
      // 1. Set Global User Session
      Provider.of<AuthProvider>(context, listen: false).setUserSession(
        userId: userId,
        username: userData['username'],
        email: userData['email'],
        phone: userData['phone'] ?? "",
        address: userData['address'] ?? "Delhi, India",
      );

      // 2. Fetch Favorites ONLY for this user
      await Provider.of<FavoritesProvider>(context, listen: false).fetchFavorites(userId);

      if (!mounted) return;
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (c) => const MainLayout())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      "images/welcome.png", 
                      height: 270,
                    ),
                  ),
                ),
                
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Demo Login: testkraft / testkraft",
                        style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        data: Icons.person,
                        controller: _userController,
                        hintText: "Username",
                        isObscure: false,
                      ),
                      CustomTextField(
                        data: Icons.lock,
                        controller: _passController,
                        hintText: "Password",
                        isObscure: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      onPressed: _attemptLogin,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
