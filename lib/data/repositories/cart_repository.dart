import 'package:flutter/foundation.dart';
import 'package:yummy/data/models/cart_item_model.dart';
import 'package:yummy/data/models/product_model.dart';

/// The user's cart, shared by every screen. Listen to it to rebuild when it
/// changes.
// TODO: persist the cart and sync it with the API
class CartRepository extends ChangeNotifier {
  CartRepository._();

  static final instance = CartRepository._();

  // kept in the order the products were first added
  final _items = <CartItemModel>[];

  List<CartItemModel> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  /// Total number of portions, for the cart badge.
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);

  void add(ProductModel product, {int quantity = 1}) {
    final index = _indexOf(product.id);
    if (index == -1) {
      _items.add(CartItemModel(product: product, quantity: quantity));
    } else {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + quantity,
      );
    }
    notifyListeners();
  }

  /// Removes the product when [quantity] drops to 0.
  void setQuantity(String productId, int quantity) {
    final index = _indexOf(productId);
    if (index == -1) return;
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void remove(String productId) => setQuantity(productId, 0);

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int _indexOf(String productId) =>
      _items.indexWhere((item) => item.product.id == productId);
}
