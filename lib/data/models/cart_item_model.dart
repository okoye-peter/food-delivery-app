import 'package:yummy/data/models/product_model.dart';

/// A product and how many of it are in the cart (or in a placed order).
class CartItemModel {
  const CartItemModel({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;

  double get total => product.price * quantity;

  CartItemModel copyWith({int? quantity}) =>
      CartItemModel(product: product, quantity: quantity ?? this.quantity);
}
