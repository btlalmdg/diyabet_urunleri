import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../data/cart_controller.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> data = json.decode(response);

      setState(() {
        products =
            data.map((p) => Product.fromJson(p as Map<String, dynamic>)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Ürünler yüklenirken hata oluştu: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AnimatedBuilder(
          animation: CartController.instance,
          builder: (context, _) {
            return IconButton(
              tooltip: 'Sepetim',
              icon: Badge(
                isLabelVisible: CartController.instance.itemCount > 0,
                label: Text('${CartController.instance.itemCount}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/cart'),
            );
          },
        ),
        title: const Text('Diyabet Ürünleri'),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        actions: [
          IconButton(
            tooltip: 'Profilim',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.of(context).pushNamed('/profile'),
          ),
        ],
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error != null
              ? Center(
                  child: Text(error!),
                )
              : Column(
                  children: [
                    // Ana Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.blue[50],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sağlığınız İçin Seçili Ürünler',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${products.length} ürün mevcut',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Ürün Listesi
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: products[index],
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/product-detail',
                                arguments: products[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadProducts,
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
