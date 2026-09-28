import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'promo_banner_artwork.dart';
part 'promo_banner_style.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.title,
    required this.style,
    this.aspectRatio = defaultAspectRatio,
    this.onTap,
  });

  final String title;
  final PromoBannerStyle style;

  final double aspectRatio;
  final VoidCallback? onTap;

  static const defaultAspectRatio = 351 / 160;

  static const designWidth = 351.0;
  static const designHeight = 142.0;
  static const _radius = 10.0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: GestureDetector(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            // Artwork scales with the height and sticks to the right edge
            final artScale = height / designHeight;
            final artLeft = width - designWidth * artScale;
            // Title scales with the width so it wraps the same as Figma
            final textScale = width / designWidth;

            Widget artwork(List<Widget> layers) => Positioned(
              left: artLeft,
              top: 0,
              width: designWidth,
              height: designHeight,
              child: Transform.scale(
                scale: artScale,
                alignment: Alignment.topLeft,
                child: Stack(clipBehavior: Clip.none, children: layers),
              ),
            );

            // Layer order matches Figma: background, food, clipped frame
            // (glow, podium, stars, title), then light beams on top.
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_radius),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: style.gradient,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: style.shadowColor,
                          offset: const Offset(0, 24),
                          blurRadius: 24,
                          spreadRadius: -24,
                        ),
                      ],
                    ),
                  ),
                ),

                // Not clipped: the food may stick out above the banner
                artwork([_Food(food: style.food)]),

                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_radius),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        artwork([
                          if (style.hasGlow)
                            const Positioned(
                              left: -58,
                              top: 53,
                              width: 234.457,
                              height: 234.457,
                              child: CustomPaint(painter: _GlowPainter()),
                            ),
                          if (style.hasLightBand) const _LightBand(),
                          Positioned(
                            left: 193,
                            top: 111,
                            width: 127,
                            height: 59,
                            child: CustomPaint(
                              painter: _PodiumPainter(style.podium),
                            ),
                          ),
                          for (final star in style.stars)
                            _Star(star: star, color: style.starColor),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(left: 14 * textScale),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 149 * textScale,
                              child: Text(
                                title,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFFBFBFB),
                                  fontSize: 24 * textScale,
                                  fontWeight: FontWeight.w700,
                                  height: 28 / 24,
                                  letterSpacing: -0.24 * textScale,
                                  shadows: const [
                                    Shadow(
                                      color: Color(0x26000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                artwork([
                  Positioned(
                    left: 174,
                    top: 51,
                    width: 169,
                    height: 72,
                    child: CustomPaint(
                      painter: _BeamPainter.back(
                        style.backBeamColor,
                        style.beamFadeColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 147,
                    top: 63,
                    width: 215,
                    height: 60,
                    child: CustomPaint(
                      painter: _BeamPainter.front(
                        style.frontBeamColor,
                        style.beamFadeColor,
                      ),
                    ),
                  ),
                ]),
              ],
            );
          },
        ),
      ),
    );
  }
}
