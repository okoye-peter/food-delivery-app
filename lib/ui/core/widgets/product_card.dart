import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/cart_button.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/core/widgets/rating_label.dart';
import 'package:yummy/ui/core/widgets/save_button.dart';
import 'package:yummy/ui/screens/home/widgets/promo_badge.dart';
import 'package:yummy/utils/formatters.dart';

/// Grid card for the menu and saved meals: picture with a heart, name,
/// category, rating, price and an add-to-cart button.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  /// Height to give the card in a grid.
  static const height = 262.0;

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0.8,
      margin: EdgeInsets.zero,
      color: context.colors.cardBackground,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.push(AppRoutes.productDetail(product.id)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: ProductImageTile.colorFor(product.id),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(product.image, fit: BoxFit.contain),
                      ),
                    ),
                    if (product.isOnPromo)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: PromoBadge(
                          label: '-${product.discountPercent}%',
                        ),
                      ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: SaveButton(product: product, size: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: context.colors.sectionTitle,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                product.category.name,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: context.colors.inputLabel,
                ),
              ),
              const SizedBox(height: 6),
              RatingLabel(
                rating: product.rating,
                count: product.ratingCount,
                fontSize: 12,
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (product.isOnPromo)
                          Text(
                            formatPrice(product.originalPrice!),
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: context.colors.inputLabel,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: context.colors.inputLabel,
                            ),
                          ),
                        Text(
                          formatPrice(product.price),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: context.colors.sectionTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Add to cart',
                    onPressed: () => addToCart(context, product),
                    iconSize: 20,
                    style: IconButton.styleFrom(
                      fixedSize: const Size.square(34),
                      minimumSize: const Size.square(34),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
