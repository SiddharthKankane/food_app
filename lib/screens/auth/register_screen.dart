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
    if (_userController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _phoneController.text.isEmpty || 
        _locationController.text.isEmpty ||
        _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('register_validation_snackbar'),
          content: Text("Please fill in all fields")
        ),
      );
      return;
    }

    if (_passController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('register_password_mismatch_snackbar'),
          content: Text("Passwords do not match!")
        ),
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
      const SnackBar(
        key: Key('register_success_snackbar'),
        content: Text("Account created! Please login.")
      ),
    );
    
    DefaultTabController.of(context).animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('register_scaffold'),
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
            key: const Key('register_scroll_view'),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  "images/welcome.png",
                  key: const Key('register_welcome_image'),
                  height: 150,
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        key: const Key('register_username_field'),
                        data: Icons.person,
                        controller: _userController,
                        hintText: "Username",
                        isObscure: false,
                      ),
                      CustomTextField(
                        key: const Key('register_email_field'),
                        data: Icons.email,
                        controller: _emailController,
                        hintText: "Email ID",
                        isObscure: false,
                      ),
                      CustomTextField(
                        key: const Key('register_phone_field'),
                        data: Icons.phone,
                        controller: _phoneController,
                        hintText: "Phone Number",
                        isObscure: false,
                      ),
                      CustomTextField(
                        key: const Key('register_location_field'),
                        data: Icons.my_location,
                        controller: _locationController,
                        hintText: "Delivery Address",
                        enabled: true,
                      ),
                      CustomTextField(
                        key: const Key('register_password_field'),
                        data: Icons.lock,
                        controller: _passController,
                        hintText: "Password",
                        isObscure: true,
                      ),
                      CustomTextField(
                        key: const Key('register_confirm_password_field'),
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
                  ? const CircularProgressIndicator(
                      key: Key('register_loading_indicator'),
                      color: Colors.white
                    )
                  : ElevatedButton(
                      key: const Key('register_submit_button'),
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
