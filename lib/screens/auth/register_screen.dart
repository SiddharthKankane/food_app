import 'package:flutter/material.dart';
import 'package:food_app/widgets/custom_text_field.dart';
import 'package:food_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  
  bool _isLoading = false;

  void _handleRegister() async {
    // Basic Validation
    if (_userController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _phoneController.text.isEmpty || 
        _locationController.text.isEmpty ||
        _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    if (_passController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    await AuthService.register(
      _userController.text, 
      _passController.text,
      _emailController.text,
      _phoneController.text,
      _locationController.text,
    );
    
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created! Please login.")),
    );
    
    DefaultTabController.of(context).animateTo(0);
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
                const SizedBox(height: 20),
                Image.asset(
                  "images/welcome.png",
                  height: 150,
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        data: Icons.person,
                        controller: _userController,
                        hintText: "User ID",
                        isObscure: false,
                      ),
                      CustomTextField(
                        data: Icons.email,
                        controller: _emailController,
                        hintText: "Email ID",
                        isObscure: false,
                      ),
                      CustomTextField(
                        data: Icons.phone,
                        controller: _phoneController,
                        hintText: "Phone Number",
                        isObscure: false,
                      ),
                      CustomTextField(
                        data: Icons.my_location,
                        controller: _locationController,
                        hintText: "Delivery Address",
                        enabled: true,
                      ),
                      CustomTextField(
                        data: Icons.lock,
                        controller: _passController,
                        hintText: "Password",
                        isObscure: true,
                      ),
                      CustomTextField(
                        data: Icons.lock_outline,
                        controller: _confirmPassController,
                        hintText: "Confirm Password",
                        isObscure: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      onPressed: _handleRegister,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      child: const Text("Register", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
