import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// ★ 4.5 (128)
class RatingLabel extends StatelessWidget {
  const RatingLabel({
    super.key,
    required this.rating,
    required this.count,
    this.fontSize = 13,
  });

  final double rating;
  final int count;
  final double fontSize;

  static const starColor = Color(0xFFF3AE2B);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: starColor, size: fontSize + 5),
        const SizedBox(width: 3),
        Text(
          rating.toString(),
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: context.colors.inputText,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          '($count)',
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: context.colors.inputLabel,
          ),
        ),
      ],
    );
  }
}
