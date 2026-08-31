import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'İnsülin Cihazları':
        return Colors.blue[400]!;
      case 'Ölçüm Cihazları':
        return Colors.green[400]!;
      case 'Tüketim Malzemeleri':
        return Colors.red[400]!;
      case 'Eğitim Malzemeleri':
        return Colors.amber[400]!;
      case 'Ayakkabı Ürünleri':
        return Colors.orange[400]!;
      case 'Saklama Ürünleri':
        return Colors.purple[400]!;
      case 'Test Kitleri':
        return Colors.pink[400]!;
      case 'Yazılım':
        return Colors.cyan[400]!;
      default:
        return Colors.teal[400]!;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'İnsülin Cihazları':
        return Icons.health_and_safety;
      case 'Ölçüm Cihazları':
        return Icons.show_chart;
      case 'Tüketim Malzemeleri':
        return Icons.factory;
      case 'Eğitim Malzemeleri':
        return Icons.school;
      case 'Ayakkabı Ürünleri':
        return Icons.dry_cleaning;
      case 'Saklama Ürünleri':
        return Icons.kitchen;
      case 'Test Kitleri':
        return Icons.biotech;
      case 'Yazılım':
        return Icons.apps;
      default:
        return Icons.medical_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(product.category);
    final categoryIcon = _getCategoryIcon(product.category);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürün Resmi
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      categoryColor,
                      categoryColor.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        categoryIcon,
                        size: 60,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            // İçerik
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ürün Adı
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Kategori
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating} (${product.reviews})',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Fiyat
                  Text(
                    '₺${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
