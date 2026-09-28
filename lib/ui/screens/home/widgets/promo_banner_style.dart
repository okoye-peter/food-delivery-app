part of 'promo_banner.dart';

/// Colours, food and star layout for one banner variant. Positions are in
/// Figma's 351 x 142 banner coordinates.
class PromoBannerStyle {
  const PromoBannerStyle({
    required this.gradient,
    required this.shadowColor,
    required this.food,
    required this.podium,
    required this.backBeamColor,
    required this.frontBeamColor,
    required this.beamFadeColor,
    required this.starColor,
    required this.stars,
    this.hasGlow = false,
    this.hasLightBand = false,
  });

  /// Bottom-left to top-right.
  final List<Color> gradient;
  final Color shadowColor;
  final PromoFood food;
  final PodiumColors podium;
  final Color backBeamColor;
  final Color frontBeamColor;
  final Color beamFadeColor;
  final Color starColor;
  final List<PromoStar> stars;

  /// Soft circle behind the title (Figma "Banner 1").
  final bool hasGlow;

  /// Faint diagonal light across the left side (Figma "Banner 2").
  final bool hasLightBand;

  /// Figma "Banner 1": orange, noodle bowl.
  static const orange = PromoBannerStyle(
    gradient: [Color(0xFFFF8A35), Color(0xFFFFC014)],
    shadowColor: Color(0x73CD7B20),
    food: PromoFood(
      imagePath: 'assets/images/dashboard/noodle_bowl.png',
      center: Offset(267, 62),
      size: Size(142, 90),
      shadowOffset: 25,
      shadowBlur: 7.5,
      shadowColor: Color(0x1A000000),
    ),
    podium: PodiumColors(
      body: Color(0xFFFDA95B),
      rim: Color(0xFFFFD88B),
      top: Color(0xFFFBE2B2),
      innerShadow: Color(0xB0FFFFFF),
    ),
    backBeamColor: Color(0xFFFBE6B2),
    frontBeamColor: Color(0xFFFBD0B2),
    beamFadeColor: Color(0x00FBF1B2),
    starColor: Color(0xFFF9DDB0),
    stars: [
      PromoStar(center: Offset(179.25, 98.25), size: 14.31, degrees: -34.17),
      PromoStar(center: Offset(183.82, 55.82), size: 7.27, degrees: -13.13),
      PromoStar(center: Offset(319.52, 101.53), size: 11.69, degrees: 30),
      PromoStar(center: Offset(330.63, 52.64), size: 5.40, degrees: 30),
    ],
    hasGlow: true,
  );

  /// Figma "Banner 2": dark grey, dumpling basket.
  static const grey = PromoBannerStyle(
    gradient: [Color(0xFF3A3938), Color(0xFF797672)],
    shadowColor: Color(0x73000000),
    food: PromoFood(
      imagePath: 'assets/images/dashboard/dumpling_basket.png',
      center: Offset(253.75, 41.95),
      size: Size(145.2, 115.9),
      degrees: -10.25,
      shadowOffset: 18,
      shadowBlur: 11,
      shadowColor: Color(0x33000000),
    ),
    podium: PodiumColors(
      body: Color(0xFF5C5751),
      rim: Color(0xFFAFADA8),
      top: Color(0xFFCBCBCA),
      innerShadow: Color(0xABFFFFFF),
    ),
    backBeamColor: Color(0xFFCBCBCA),
    frontBeamColor: Color(0xFFCBCBCA),
    beamFadeColor: Color(0x003A3938),
    starColor: Color(0xFF9D9D9D),
    stars: [
      PromoStar(
        center: Offset(179.25, 98.25),
        size: 14.31,
        degrees: -34.17,
        opacity: 0.5,
      ),
      PromoStar(
        center: Offset(175.81, 53.82),
        size: 7.27,
        degrees: -13.13,
        opacity: 0.3,
      ),
      PromoStar(
        center: Offset(319.52, 101.53),
        size: 11.69,
        degrees: 30,
        opacity: 0.5,
      ),
      PromoStar(
        center: Offset(330.63, 52.64),
        size: 5.40,
        degrees: 30,
        opacity: 0.5,
      ),
    ],
    hasLightBand: true,
  );
}

class PromoFood {
  const PromoFood({
    required this.imagePath,
    required this.center,
    required this.size,
    this.degrees = 0,
    required this.shadowOffset,
    required this.shadowBlur,
    required this.shadowColor,
  });

  final String imagePath;
  final Offset center;
  final Size size;
  final double degrees;
  final double shadowOffset;
  final double shadowBlur;
  final Color shadowColor;
}

class PodiumColors {
  const PodiumColors({
    required this.body,
    required this.rim,
    required this.top,
    required this.innerShadow,
  });

  final Color body;
  final Color rim;
  final Color top;
  final Color innerShadow;
}

class PromoStar {
  const PromoStar({
    required this.center,
    required this.size,
    required this.degrees,
    this.opacity = 1,
  });

  final Offset center;
  final double size;
  final double degrees;
  final double opacity;
}
