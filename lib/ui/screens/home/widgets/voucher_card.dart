import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/voucher_model.dart';

/// Discount voucher, drawn from the 152×80 design: orange card with diagonal
/// bands, a white panel showing the discount and code, two overlapping
/// facets on the right and a usage count badge. Turns grey when the voucher
/// has no uses left.
///
/// Everything is laid out in design units and scaled to the available width.
class VoucherCard extends StatelessWidget {
  const VoucherCard({super.key, required this.voucher, this.onTap});

  final VoucherModel voucher;
  final VoidCallback? onTap;

  static const designSize = Size(152, 80);
  static const _radius = 8.0;

  static const _orange = _VoucherPalette(
    background: Color(0xFFFFC56F),
    bandLight: Color(0xFFFFB067),
    bandDark: Color(0xFFFFA654),
    panel: Colors.white,
    panelInner: Color(0xFFFFFBF5),
    panelShadow: Color(0x82B9721E),
    backFacet: [Color(0xFFF5A861), Color(0xFFF59439)],
    frontFacet: [Color(0xFFFEB36E), Color(0xFFFE9B40)],
    facetShadow: Color(0x407E2E00),
    badge: Color(0xFFF28017),
    discountText: Color(0xFFF28017),
    codeText: Color(0xFF2A2A2A),
  );

  static const _grey = _VoucherPalette(
    background: Color(0xFFE4E4E4),
    bandLight: Color(0xFFDADADA),
    bandDark: Color(0xFFD2D2D2),
    panel: Colors.white,
    panelInner: Color(0xFFFAFAFA),
    panelShadow: Color(0x40000000),
    backFacet: [Color(0xFFD0D0D0), Color(0xFFC2C2C2)],
    frontFacet: [Color(0xFFDCDCDC), Color(0xFFC9C9C9)],
    facetShadow: Color(0x26000000),
    badge: Color(0xFFBDBDBD),
    discountText: Color(0xFFA6A6A6),
    codeText: Color(0xFFA6A6A6),
  );

  @override
  Widget build(BuildContext context) {
    final palette = voucher.isAvailable ? _orange : _grey;

    return AspectRatio(
      aspectRatio: designSize.aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: voucher.isAvailable ? onTap : null,
            child: FittedBox(
              child: SizedBox.fromSize(
                size: designSize,
                child: CustomPaint(
                  painter: _VoucherPainter(palette),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 18,
                        top: 19,
                        // stay clear of the facets on the right
                        width: 82,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ScaleDownText(
                              voucher.discount,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: palette.discountText,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 3),
                            _ScaleDownText(
                              'Enter ${voucher.code}',
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: palette.codeText,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 121,
                        top: 6,
                        width: 25,
                        height: 16,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: palette.badge,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: _ScaleDownText(
                              'X${voucher.remaining}',
                              style: GoogleFonts.inter(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Single line of text that shrinks instead of overflowing.
class _ScaleDownText extends StatelessWidget {
  const _ScaleDownText(this.text, {required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text, maxLines: 1, style: style),
    );
  }
}

class _VoucherPalette {
  const _VoucherPalette({
    required this.background,
    required this.bandLight,
    required this.bandDark,
    required this.panel,
    required this.panelInner,
    required this.panelShadow,
    required this.backFacet,
    required this.frontFacet,
    required this.facetShadow,
    required this.badge,
    required this.discountText,
    required this.codeText,
  });

  final Color background;

  /// Diagonal bands in the bottom-left corner.
  final Color bandLight;
  final Color bandDark;

  final Color panel;

  /// Softly blurred fill inside [panel], gives the panel a faint rim.
  final Color panelInner;
  final Color panelShadow;

  /// [start, end] gradients for the two facets on the right.
  final List<Color> backFacet;
  final List<Color> frontFacet;
  final Color facetShadow;

  final Color badge;
  final Color discountText;
  final Color codeText;
}

/// Paints everything except the text and badge, in 152×80 design units.
class _VoucherPainter extends CustomPainter {
  _VoucherPainter(this.palette);

  final _VoucherPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = palette.background);

    // diagonal bands: squares rotated -30° about their top-left corner
    _drawBand(canvas, const Offset(-89, 39.2766), palette.bandLight);
    _drawBand(canvas, const Offset(-112, 39.2766), palette.bandDark);

    // white panel with a warm drop shadow
    final panel = RRect.fromLTRBR(6, 6, 146, 74, const Radius.circular(6));
    canvas.drawRRect(
      panel.shift(const Offset(0.69, 0.69)),
      Paint()
        ..color = palette.panelShadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawRRect(panel, Paint()..color = palette.panel);
    canvas.drawRRect(
      RRect.fromLTRBR(8, 8, 144, 72, const Radius.circular(6)),
      Paint()
        ..color = palette.panelInner
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
    );

    // facets over the panel's right side; both share the card's right edge
    final backFacet = Path()
      ..moveTo(122.595, 0)
      ..lineTo(152, 0)
      ..lineTo(152, 80)
      ..lineTo(88.5, 80)
      ..lineTo(113, 40)
      ..close();
    _drawFacet(
      canvas,
      backFacet,
      const Offset(120.961, 83.1579),
      const Offset(100.949, 12.978),
      palette.backFacet,
    );

    final frontFacet = Path()
      ..moveTo(104, 0)
      ..lineTo(152, 0)
      ..lineTo(152, 80)
      ..lineTo(122.595, 80)
      ..close();
    _drawFacet(
      canvas,
      frontFacet,
      const Offset(120.961, -3.1579),
      const Offset(100.949, 67.022),
      palette.frontFacet,
    );
  }

  void _drawBand(Canvas canvas, Offset origin, Color color) {
    const side = 116.553;
    canvas
      ..save()
      ..translate(origin.dx, origin.dy)
      ..rotate(-30 * math.pi / 180)
      ..drawRect(const Rect.fromLTWH(0, 0, side, side), Paint()..color = color)
      ..restore();
  }

  void _drawFacet(
    Canvas canvas,
    Path path,
    Offset gradientStart,
    Offset gradientEnd,
    List<Color> colors,
  ) {
    canvas.drawPath(
      path,
      Paint()
        ..color = palette.facetShadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawPath(
      path,
      Paint()..shader = ui.Gradient.linear(gradientStart, gradientEnd, colors),
    );
  }

  @override
  bool shouldRepaint(_VoucherPainter oldDelegate) =>
      oldDelegate.palette != palette;
}
