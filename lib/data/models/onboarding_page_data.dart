import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.bannerColors,
    required this.topLeftBadgeBuilder,
    required this.accentBadgeBuilder,
    this.topLeftBadgeTop = 0.33,
    this.accentBadgeTop = 0.55,
    this.accentBadgeRight = 30,
  });

  final String imageAsset;
  final String title;
  final String description;
  final List<Color> bannerColors;
  final WidgetBuilder topLeftBadgeBuilder;
  final WidgetBuilder accentBadgeBuilder;

  /// Badge offsets from the top, as fractions of the banner height.
  final double topLeftBadgeTop;
  final double accentBadgeTop;
  final double accentBadgeRight;
}
