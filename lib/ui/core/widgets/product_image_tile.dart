import 'package:flutter/material.dart';

/// Product picture on a rounded coloured background.
///
/// The image sits in a fixed [imageWidth] x [imageHeight] box, so tiles line
/// up; images that don't match that ratio shrink to fit (contain) and stay
/// centred.
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

  /// Fixed fill for a product, so it keeps the same colour on every screen.
  static Color colorFor(String productId) =>
      backgroundColors[productId.codeUnits.fold(0, (sum, unit) => sum + unit) %
          backgroundColors.length];

  /// Asset path of the product image.
  final String image;
  final Color backgroundColor;

  /// Image box width. The dummy images are 620px wide, so they must be sized
  /// explicitly.
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
      // fixed box so every tile is the same size whatever the image's aspect
      // ratio
      child: SizedBox(
        width: imageWidth,
        height: imageHeight,
        child: Image.asset(image, fit: BoxFit.contain),
      ),
    );
  }
}
