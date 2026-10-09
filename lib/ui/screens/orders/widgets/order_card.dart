import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/repositories/cart_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/core/widgets/rating_label.dart';
import 'package:yummy/ui/screens/orders/widgets/order_status_chip.dart';
import 'package:yummy/utils/formatters.dart';

/// Order in the orders list: number, status, item pictures, total and the
/// next thing the user can do with it (track, rate or reorder).
class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;

  static const _maxThumbnails = 3;

  void _reorder(BuildContext context) {
    final cart = CartRepository.instance;
    for (final item in order.items) {
      cart.add(item.product, quantity: item.quantity);
    }
    context.push(AppRoutes.cart);
  }

  @override
  Widget build(BuildContext context) {
    final extraItems = order.items.length - _maxThumbnails;
    final rating = order.rating;

    return Card(
      elevation: 0.8,
      margin: EdgeInsets.zero,
      color: context.colors.cardBackground,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.push(AppRoutes.orderDetail(order.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order #${order.id}',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.colors.sectionTitle,
                      ),
                    ),
                  ),
                  OrderStatusChip(status: order.status),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                formatDateTime(order.placedAt),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: context.colors.inputLabel,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (final item in order.items.take(_maxThumbnails))
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: ProductImageTile.colorFor(item.product.id),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(item.product.image),
                      ),
                    ),
                  if (extraItems > 0)
                    Text(
                      '+$extraItems',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: context.colors.subtitle,
                      ),
                    ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatPrice(order.total),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: context.colors.sectionTitle,
                        ),
                      ),
                      Text(
                        '${order.itemCount} item${order.itemCount == 1 ? '' : 's'}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: context.colors.inputLabel,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  if (rating != null)
                    Expanded(
                      child: Row(
                        children: [
                          for (var i = 1; i <= 5; i++)
                            Icon(
                              i <= rating.stars
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 18,
                              color: RatingLabel.starColor,
                            ),
                        ],
                      ),
                    )
                  else
                    const Spacer(),
                  if (order.status.isActive)
                    _CardButton(
                      label: 'Track order',
                      filled: true,
                      onPressed: () =>
                          context.push(AppRoutes.orderDetail(order.id)),
                    )
                  else ...[
                    _CardButton(
                      label: 'Reorder',
                      onPressed: () => _reorder(context),
                    ),
                    if (order.canRate) ...[
                      const SizedBox(width: 8),
                      _CardButton(
                        label: 'Rate',
                        filled: true,
                        onPressed: () =>
                            context.push(AppRoutes.rateOrder(order.id)),
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.label,
    required this.onPressed,
    this.filled = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    final textStyle = GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w700,
    );

    return filled
        ? FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              shape: shape,
              textStyle: textStyle,
              visualDensity: VisualDensity.compact,
            ),
            child: Text(label),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colors.inputText,
              side: BorderSide(color: context.colors.divider),
              shape: shape,
              textStyle: textStyle,
              visualDensity: VisualDensity.compact,
            ),
            child: Text(label),
          );
  }
}
