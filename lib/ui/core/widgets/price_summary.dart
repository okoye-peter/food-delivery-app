import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/utils/formatters.dart';

/// Subtotal, delivery fee, discount and total lines.
class PriceSummary extends StatelessWidget {
  const PriceSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    this.discount = 0,
  });

  final double subtotal;
  final double deliveryFee;
  final double discount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Line(label: 'Subtotal', value: formatPrice(subtotal)),
        _Line(label: 'Delivery fee', value: formatPrice(deliveryFee)),
        if (discount > 0)
          _Line(
            label: 'Discount',
            value: '-${formatPrice(discount)}',
            valueColor: const Color(0xFF2E9E5B),
          ),
        Divider(height: 20, color: context.colors.divider),
        _Line(
          label: 'Total',
          value: formatPrice(subtotal + deliveryFee - discount),
          bold: true,
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final size = bold ? 17.0 : 14.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: bold
                  ? context.colors.sectionTitle
                  : context.colors.subtitle,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              color: valueColor ?? context.colors.sectionTitle,
            ),
          ),
        ],
      ),
    );
  }
}
