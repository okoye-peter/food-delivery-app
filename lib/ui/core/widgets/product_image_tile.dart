import 'package:flutter/material.dart';

/// Product picture on a rounded coloured background.
///
/// The image is capped at [imageWidth] and fixed at [imageHeight]; wide
/// images shrink to fit (contain) and stay centred.
class ProductImageTile extends StatelessWidget {
  const ProductImageTile({
    super.key,
    required this.image,
    required this.backgroundColor,
    this.imageWidth = 80,
    this.imageHeight = 70,
  });

  /// Pastel fills that product lists cycle through.
  static const backgroundColors = [
    Color(0xFFF9CA60), // yellow
    Color(0xFFF4A988), // peach
    Color(0xFF9FD3C7), // mint
    Color(0xFFA8C5F7), // blue
    Color(0xFFC9B6F2), // lavender
    Color(0xFFF6A5B5), // pink
    Color(0xFFB5DE8C), // green
  ];

  /// Asset path of the product image.
  final String image;
  final Color backgroundColor;

  /// Maximum image width. The dummy images are 620px wide, so they must be
  /// sized explicitly.
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: imageWidth),
        child: Image.asset(image, height: imageHeight, fit: BoxFit.contain),
      ),
    );
  }
}
