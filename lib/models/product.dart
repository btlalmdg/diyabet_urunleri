class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rating;
  final int reviews;
  final String manufacturer;
  final List<String> benefits;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.manufacturer,
    required this.benefits,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      manufacturer: json['manufacturer'] as String,
      benefits: List<String>.from(json['benefits'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
      'rating': rating,
      'reviews': reviews,
      'manufacturer': manufacturer,
      'benefits': benefits,
    };
  }
}

class ProductList {
  final List<Product> products;

  ProductList({required this.products});

  factory ProductList.fromJson(List<dynamic> json) {
    return ProductList(
      products: json.map((p) => Product.fromJson(p as Map<String, dynamic>)).toList(),
    );
  }
}
