import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/screens/home/widgets/nearby_product_tile.dart';
import 'package:yummy/ui/screens/search/widgets/recent_search_header.dart';
import 'package:yummy/ui/screens/search/widgets/recent_search_tile.dart';
import 'package:yummy/ui/screens/search/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  // TODO: load and save the user's search history
  final _recentSearches = ['Jollof', 'Burger', 'Soup'];

  /// Shows the matching meals in the menu and remembers the query.
  void _search(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      _recentSearches
        ..removeWhere((q) => q.toLowerCase() == trimmed.toLowerCase())
        ..insert(0, trimmed);
    });
    context.go(AppRoutes.menuWith(query: trimmed));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.pop(),
          color: context.colors.backButton,
        ),
        // field sits right next to the back button
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SearchField(
            controller: _searchController,
            onSubmitted: _search,
          ),
        ),
      ),

      // slivers so the results list builds lazily while scrolling together
      // with the recent searches above it
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 18, 12, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_recentSearches.isNotEmpty)
                        RecentSearchHeader(
                          onClearAll: () =>
                              setState(() => _recentSearches.clear()),
                        ),
                      for (final query in _recentSearches)
                        RecentSearchTile(
                          query: query,
                          onTap: () => _search(query),
                          onRemove: () =>
                              setState(() => _recentSearches.remove(query)),
                        ),
                    ],
                  ),
                ),

                Divider(height: 1, thickness: 1, color: context.colors.divider),
              ],
            ),
          ),

          // search results will go here
          SliverPadding(
            // keep the last tile clear of the home indicator
            padding: EdgeInsets.fromLTRB(10, 30, 10, 15 + paddingBottom),
            sliver: SliverList.separated(
              itemCount: nearbyProducts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 15),
              itemBuilder: (_, index) => NearbyProductTile(
                product: nearbyProducts[index],
                // same colour as on the meal's own page
                backgroundColor: ProductImageTile.colorFor(
                  nearbyProducts[index].id,
                ),
                onTap: () => context.push(
                  AppRoutes.productDetail(nearbyProducts[index].id),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
