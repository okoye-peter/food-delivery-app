import 'package:flutter/material.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/screens/home/widgets/home_section_card.dart';
import 'package:yummy/ui/screens/home/widgets/nearby_product_tile.dart';

/// "Near you" card: a filter button and a vertical list of nearby products.
class HomeNearbyProducts extends StatefulWidget {
  const HomeNearbyProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<HomeNearbyProducts> createState() => _HomeNearbyProductsState();
}

class _HomeNearbyProductsState extends State<HomeNearbyProducts> {
  // Shuffled once per widget, not per build, so the colours don't flash on
  // every setState
  final _tileColors = [...ProductImageTile.backgroundColors]..shuffle();

  @override
  Widget build(BuildContext context) {
    final products = widget.products;

    return HomeSectionCard(
      title: 'Near you',
      // TODO: open the filters
      trailing: Icon(Icons.tune, color: context.colors.inputText, size: 28),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
        // sits inside the home scroll view: take the height of the items and
        // let the page do the scrolling
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 15),
        itemBuilder: (_, index) => NearbyProductTile(
          product: products[index],
          backgroundColor: _tileColors[index % _tileColors.length],
        ),
      ),
    );
  }
}
