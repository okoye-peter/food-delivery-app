import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Blue "PROMO" tag whose bottom edge comes to a shallow point.
class PromoBadge extends StatelessWidget {
  const PromoBadge({super.key, this.label = 'PROMO'});

  final String label;

  static const _pointDepth = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // extra bottom padding so the text stays centred above the point
      padding: const EdgeInsets.fromLTRB(6, 2, 6, 2 + _pointDepth),
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, -0.79),
          end: Alignment(1.0, 1.0),
          colors: [Color(0xFF7EAEF4), Color(0xFF3A72D6)],
        ),
        shape: _PointedBottomBorder(radius: 4, pointDepth: _pointDepth),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Rounded top corners, straight sides, and a bottom edge that slopes from
/// each side down to a point in the middle.
class _PointedBottomBorder extends ShapeBorder {
  const _PointedBottomBorder({required this.radius, required this.pointDepth});

  final double radius;
  final double pointDepth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final sideBottom = rect.bottom - pointDepth;

    return Path()
      ..moveTo(rect.left, rect.top + radius)
      ..quadraticBezierTo(rect.left, rect.top, rect.left + radius, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + radius)
      ..lineTo(rect.right, sideBottom)
      ..lineTo(rect.center.dx, rect.bottom)
      ..lineTo(rect.left, sideBottom)
      ..close();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  // Fill only; the gradient comes from ShapeDecoration
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) =>
      _PointedBottomBorder(radius: radius * t, pointDepth: pointDepth * t);
}
