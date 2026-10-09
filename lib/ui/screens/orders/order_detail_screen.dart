import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/price_summary.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/ui/core/widgets/rating_label.dart';
import 'package:yummy/ui/core/widgets/titled_card.dart';
import 'package:yummy/ui/screens/checkout/widgets/payment_method_tile.dart';
import 'package:yummy/ui/screens/orders/widgets/order_status_chip.dart';
import 'package:yummy/ui/screens/orders/widgets/order_tracker.dart';
import 'package:yummy/utils/formatters.dart';

/// One order: live status and tracker, rider, address, items and totals,
/// and the rating once it is delivered.
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  static const _gap = SizedBox(height: 14);

  @override
  Widget build(BuildContext context) {
    final orders = OrderRepository.instance;

    return ListenableBuilder(
      listenable: orders,
      builder: (context, _) {
        final order = orders.findById(orderId);
        if (order == null) {
          return const Scaffold(
            appBar: PageAppBar(title: 'Order'),
            body: EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'Order not found',
              message: 'We could not find this order.',
            ),
          );
        }

        final rating = order.rating;
        final showRider =
            order.status == OrderStatus.onTheWay && order.riderName != null;

        return Scaffold(
          appBar: PageAppBar(title: 'Order #${order.id}'),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _StatusHeader(order: order),
              _gap,
              if (showRider) ...[_RiderCard(name: order.riderName!), _gap],
              TitledCard(
                title: 'Order status',
                child: OrderTracker(order: order),
              ),
              _gap,
              TitledCard(
                title: 'Delivery details',
                child: Column(
                  children: [
                    _DetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      value: order.deliveryAddress,
                    ),
                    _DetailRow(
                      icon: paymentMethodIcon(order.paymentMethod),
                      label: 'Payment',
                      value: order.paymentMethod.label,
                    ),
                    _DetailRow(
                      icon: Icons.event_outlined,
                      label: 'Placed',
                      value: formatDateTime(order.placedAt),
                    ),
                    if (order.note != null)
                      _DetailRow(
                        icon: Icons.sticky_note_2_outlined,
                        label: 'Note',
                        value: order.note!,
                      ),
                  ],
                ),
              ),
              _gap,
              TitledCard(
                title: 'Items (${order.itemCount})',
                child: Column(
                  children: [
                    for (final item in order.items)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              '${item.quantity}×',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.product.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.sectionTitle,
                                ),
                              ),
                            ),
                            Text(
                              formatPrice(item.total),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: context.colors.sectionTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Divider(height: 24, color: context.colors.divider),
                    PriceSummary(
                      subtotal: order.subtotal,
                      deliveryFee: order.deliveryFee,
                      discount: order.discount,
                    ),
                  ],
                ),
              ),
              if (rating != null) ...[
                _gap,
                TitledCard(
                  title: 'Your rating',
                  child: _RatingSummary(rating: rating),
                ),
              ],
            ],
          ),
          bottomNavigationBar: order.canRate
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                    child: PrimaryButton(
                      label: 'Rate this order',
                      onPressed: () =>
                          context.push(AppRoutes.rateOrder(order.id)),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}

/// Big status icon, name and arrival time at the top of the page.
class _StatusHeader extends StatelessWidget {
  const _StatusHeader({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final color = orderStatusColor(order.status);
    final deliveredAt = order.statusTimes[OrderStatus.delivered];
    final timeLine = order.status.isActive
        ? 'Estimated arrival ${formatTime(order.estimatedDelivery)}'
        : deliveredAt == null
        ? ''
        : 'Delivered at ${formatTime(deliveredAt)}';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(
              orderStatusIcon(order.status),
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.status.label,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: context.colors.sectionTitle,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  order.status.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.colors.subtitle,
                  ),
                ),
                if (timeLine.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    timeLine,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RiderCard extends StatelessWidget {
  const _RiderCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TitledCard(
      title: 'Your rider',
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: colorScheme.primary,
            child: Text(
              name.characters.first,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: context.colors.sectionTitle,
                  ),
                ),
                const RatingLabel(rating: 4.9, count: 820, fontSize: 12),
              ],
            ),
          ),
          // TODO: open a chat with the rider and call them
          IconButton.filledTonal(
            tooltip: 'Message rider',
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline),
          ),
          const SizedBox(width: 4),
          IconButton.filled(
            tooltip: 'Call rider',
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            icon: const Icon(Icons.call),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: context.colors.inputText),
          const SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.colors.subtitle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.colors.sectionTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSummary extends StatelessWidget {
  const _RatingSummary({required this.rating});

  final OrderRating rating;

  @override
  Widget build(BuildContext context) {
    final comment = rating.comment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 1; i <= 5; i++)
              Icon(
                i <= rating.stars ? Icons.star : Icons.star_border,
                color: RatingLabel.starColor,
                size: 26,
              ),
          ],
        ),
        if (rating.tags.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final tag in rating.tags)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.searchFill,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.colors.inputText,
                    ),
                  ),
                ),
            ],
          ),
        ],
        if (comment != null) ...[
          const SizedBox(height: 10),
          Text(
            '"$comment"',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: context.colors.subtitle,
            ),
          ),
        ],
      ],
    );
  }
}
