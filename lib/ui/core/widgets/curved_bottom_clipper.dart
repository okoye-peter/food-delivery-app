import 'package:flutter/widgets.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  const CurvedBottomClipper({required this.curveDepth});

  final double curveDepth;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final top = h - curveDepth;
    // Control points pulled in from the edges so the curve leaves the sides
    // at an angle (no bend) while staying flat through the middle.
    final controlY = h + curveDepth / 3;

    return Path()
      ..lineTo(0, top)
      ..cubicTo(w * 0.2, controlY, w * 0.8, controlY, w, top)
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldReclip(CurvedBottomClipper oldClipper) =>
      oldClipper.curveDepth != curveDepth;
}
