import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/favorites_provider.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/order_provider.dart';
import 'package:food_app/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AuthProvider()),
        ChangeNotifierProvider(create: (c) => CartProvider()),
        ChangeNotifierProvider(create: (c) => FavoritesProvider()), // Removed early fetch
        ChangeNotifierProvider(create: (c) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BringApp Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        fontFamily: 'TimesNewRoman',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          displayMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          displaySmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          titleSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          bodySmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          labelLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          labelMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          labelSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      home: const MySplashScreen(),
    );
  }
}
