import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/data/models/product_model.dart';

class ProductRepository {
  ProductRepository._();

  static final instance = ProductRepository._();

  // TODO: fetch from the API and parse with ProductModel.fromJson
  List<ProductModel> getProducts() => catalogProducts;

  /// Looks in the home sections too: their products have their own ids.
  ProductModel? findById(String id) => [
    ...catalogProducts,
    ...promoProducts,
    ...nearbyProducts,
  ].where((p) => p.id == id).firstOrNull;

  /// Top of the price filter's range.
  double get highestPrice =>
      getProducts().fold(0, (max, p) => p.price > max ? p.price : max);
}
