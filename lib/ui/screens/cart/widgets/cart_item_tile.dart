import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/cart_item_model.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/core/widgets/quantity_stepper.dart';
import 'package:yummy/utils/formatters.dart';

/// Cart row: picture, name, line price and a quantity stepper.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  final CartItemModel item;

  /// 0 means remove.
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(AppRoutes.productDetail(product.id)),
      child: Row(
        children: [
          ProductImageTile(
            image: product.image,
            backgroundColor: ProductImageTile.colorFor(product.id),
            imageWidth: 52,
            imageHeight: 56,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: context.colors.sectionTitle,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatPrice(product.price)} each',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.colors.inputLabel,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        formatPrice(item.total),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: context.colors.sectionTitle,
                        ),
                      ),
                    ),
                    QuantityStepper(
                      quantity: item.quantity,
                      onChanged: onQuantityChanged,
                      removable: true,
                      compact: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
