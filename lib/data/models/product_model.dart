import 'package:yummy/data/models/category_model.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    this.originalPrice,
    this.rating = 0,
    this.ratingCount = 0,
    this.description,
    this.distanceKm,
  });

  final String id, name, image;
  final CategoryModel category;
  final double price, rating;
  // Price before the discount; null when the product is not on promo
  final double? originalPrice;
  final int ratingCount;

  /// Short ingredients line, e.g. "Shrimp, ham, mix vegetable".
  final String? description;

  /// Distance from the user to the restaurant, in kilometres.
  final double? distanceKm;

  bool get isOnPromo => originalPrice != null && originalPrice! > price;

  /// Whole-number percentage off, e.g. 20 for 20% off. 0 when not on promo.
  int get discountPercent =>
      isOnPromo ? ((1 - price / originalPrice!) * 100).round() : 0;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      image: json['image'] as String,
      category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      // JSON numbers may arrive as int, so go through num
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: json['ratingCount'] as int? ?? 0,
      description: json['description'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    );
  }
}
