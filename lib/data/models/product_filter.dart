import 'package:yummy/data/models/product_model.dart';

enum ProductSort {
  recommended('Recommended'),
  rating('Top rated'),
  priceLowHigh('Price: low to high'),
  priceHighLow('Price: high to low');

  const ProductSort(this.label);

  final String label;
}

/// What the menu is narrowed down to: a category, a search query and the
/// options from the filter sheet.
class ProductFilter {
  const ProductFilter({
    this.categoryId,
    this.query = '',
    this.sort = ProductSort.recommended,
    this.maxPrice,
    this.minRating = 0,
    this.dealsOnly = false,
  });

  /// Null shows every category.
  final String? categoryId;
  final String query;
  final ProductSort sort;

  /// Null means no price limit.
  final double? maxPrice;
  final double minRating;
  final bool dealsOnly;

  /// How many filter sheet options differ from the defaults, for the badge on
  /// the filter button.
  int get sheetFilterCount => [
    sort != ProductSort.recommended,
    maxPrice != null,
    minRating > 0,
    dealsOnly,
  ].where((active) => active).length;

  // marks "not passed" for the nullable fields, so copyWith can still set
  // them to null
  static const _keep = Object();

  ProductFilter copyWith({
    Object? categoryId = _keep,
    String? query,
    ProductSort? sort,
    Object? maxPrice = _keep,
    double? minRating,
    bool? dealsOnly,
  }) => ProductFilter(
    categoryId: identical(categoryId, _keep)
        ? this.categoryId
        : categoryId as String?,
    query: query ?? this.query,
    sort: sort ?? this.sort,
    maxPrice: identical(maxPrice, _keep) ? this.maxPrice : maxPrice as double?,
    minRating: minRating ?? this.minRating,
    dealsOnly: dealsOnly ?? this.dealsOnly,
  );

  /// Clears the filter sheet options but keeps the category and query.
  ProductFilter resetSheet() =>
      ProductFilter(categoryId: categoryId, query: query);

  List<ProductModel> apply(List<ProductModel> products) {
    final q = query.trim().toLowerCase();

    final results = products.where((p) {
      if (categoryId != null && p.category.id != categoryId) return false;
      if (maxPrice != null && p.price > maxPrice!) return false;
      if (p.rating < minRating) return false;
      if (dealsOnly && !p.isOnPromo) return false;
      if (q.isNotEmpty &&
          !p.name.toLowerCase().contains(q) &&
          !p.category.name.toLowerCase().contains(q) &&
          !(p.description?.toLowerCase().contains(q) ?? false)) {
        return false;
      }
      return true;
    }).toList();

    switch (sort) {
      case ProductSort.recommended:
        break;
      case ProductSort.rating:
        results.sort((a, b) => b.rating.compareTo(a.rating));
      case ProductSort.priceLowHigh:
        results.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHighLow:
        results.sort((a, b) => b.price.compareTo(a.price));
    }
    return results;
  }
}
