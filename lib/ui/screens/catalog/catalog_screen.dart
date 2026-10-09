import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_filter.dart';
import 'package:yummy/data/repositories/category_repository.dart';
import 'package:yummy/data/repositories/product_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/cart_button.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/product_card.dart';
import 'package:yummy/ui/screens/catalog/widgets/category_chips.dart';
import 'package:yummy/ui/screens/catalog/widgets/filter_sheet.dart';

/// Menu tab: every meal, narrowed down by category, search query and the
/// filter sheet.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, this.initialFilter = const ProductFilter()});

  /// From the link that opened the menu, e.g. a category tapped on home.
  final ProductFilter initialFilter;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _products = ProductRepository.instance;
  final _categories = CategoryRepository().getCategories();

  late var _filter = widget.initialFilter;

  Future<void> _openFilters() async {
    final filter = await showFilterSheet(
      context,
      filter: _filter,
      highestPrice: _products.highestPrice,
    );
    if (filter != null) setState(() => _filter = filter);
  }

  @override
  Widget build(BuildContext context) {
    final results = _filter.apply(_products.getProducts());
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: PageAppBar(
        title: 'Menu',
        showBack: false,
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () => context.push(AppRoutes.search),
            icon: Icon(Icons.search, color: context.colors.inputText),
          ),
          const CartButton(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CategoryChips(
                  categories: _categories,
                  selectedId: _filter.categoryId,
                  onSelected: (id) => setState(
                    () => _filter = _filter.copyWith(categoryId: id),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  tooltip: 'Filters',
                  onPressed: _openFilters,
                  style: IconButton.styleFrom(
                    backgroundColor: context.colors.searchFill,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Badge(
                    isLabelVisible: _filter.sheetFilterCount > 0,
                    label: Text('${_filter.sheetFilterCount}'),
                    backgroundColor: primary,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(Icons.tune, color: context.colors.inputText),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _filter.query.isEmpty
                        ? '${results.length} meals'
                        : '${results.length} results for "${_filter.query}"',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.colors.subtitle,
                    ),
                  ),
                ),
                if (_filter.query.isNotEmpty)
                  TextButton(
                    onPressed: () =>
                        setState(() => _filter = _filter.copyWith(query: '')),
                    child: Text(
                      'Clear search',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: context.colors.link,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: results.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: 'No meals found',
                    message: 'Try another category or loosen the filters.',
                    actionLabel: 'Clear filters',
                    onAction: () =>
                        setState(() => _filter = const ProductFilter()),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                    // two columns on phones, more on tablets
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisExtent: ProductCard.height,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemCount: results.length,
                    itemBuilder: (_, index) =>
                        ProductCard(product: results[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
