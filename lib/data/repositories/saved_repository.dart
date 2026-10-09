import 'package:flutter/foundation.dart';
import 'package:yummy/data/models/product_model.dart';

/// Meals the user hearted. Listen to it to rebuild when it changes.
// TODO: persist saved items and sync them with the API
class SavedRepository extends ChangeNotifier {
  SavedRepository._();

  static final instance = SavedRepository._();

  final _items = <ProductModel>[];

  /// Most recently saved first.
  List<ProductModel> get items => List.unmodifiable(_items.reversed);

  bool isSaved(String productId) => _items.any((p) => p.id == productId);

  void toggle(ProductModel product) {
    if (isSaved(product.id)) {
      _items.removeWhere((p) => p.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }
}
