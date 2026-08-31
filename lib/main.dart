import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diyabet Ürünleri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/product-detail': (context) {
          final product = ModalRoute.of(context)?.settings.arguments as Product;
          return ProductDetailScreen(product: product);
        },
      },
    );
  }
}
