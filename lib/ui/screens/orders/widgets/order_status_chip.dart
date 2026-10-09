import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';

/// Colour for each status, readable on light and dark cards.
Color orderStatusColor(OrderStatus status) => switch (status) {
  OrderStatus.placed => const Color(0xFF3A72D6),
  OrderStatus.preparing => const Color(0xFFE08A1E),
  OrderStatus.onTheWay => const Color(0xFF8E5BD8),
  OrderStatus.delivered => const Color(0xFF2E9E5B),
};

IconData orderStatusIcon(OrderStatus status) => switch (status) {
  OrderStatus.placed => Icons.receipt_long,
  OrderStatus.preparing => Icons.soup_kitchen_outlined,
  OrderStatus.onTheWay => Icons.delivery_dining,
  OrderStatus.delivered => Icons.check_circle_outline,
};

/// Small tinted pill with the status name.
class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = orderStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
