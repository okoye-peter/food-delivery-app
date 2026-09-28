import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';

/// "Near you" row: product picture on the left; name, category, rating and
/// distance on the right.
class NearbyProductTile extends StatelessWidget {
  const NearbyProductTile({
    super.key,
    required this.product,
    required this.backgroundColor,
    this.onTap,
  });

  final ProductModel product;

  /// Fill behind the product picture.
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ProductImageTile(
            image: product.image,
            backgroundColor: backgroundColor,
            imageWidth: 70,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: context.colors.sectionTitle,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.category.name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.colors.inputLabel,
                  ),
                ),
                const SizedBox(height: 13),
                _RatingAndDistance(product: product),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ★ 4.5 (128) | 📍 1.2km
class _RatingAndDistance extends StatelessWidget {
  const _RatingAndDistance({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final boldStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: context.colors.sectionTitle,
    );
    final distance = product.distanceKm;

    // shrink the whole row on narrow screens or large text instead of
    // overflowing
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Color(0xFFF3AE2B), size: 22),
          const SizedBox(width: 3),
          Text(product.rating.toString(), style: boldStyle),
          const SizedBox(width: 3),
          Text(
            '(${product.ratingCount})',
            style: boldStyle.copyWith(color: context.colors.inputLabel),
          ),
          if (distance != null) ...[
            const SizedBox(width: 1),
            SizedBox(
              // VerticalDivider takes its parent's height; give it one
              height: 18,
              child: VerticalDivider(
                thickness: 1.5,
                color: context.colors.inputLabel,
              ),
            ),
            const SizedBox(width: 1),
            Icon(
              Icons.location_on_outlined,
              color: context.colors.inputText,
              size: 18,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(width: 3),
            Text('${distance}km', style: boldStyle),
          ],
        ],
      ),
    );
  }
}
