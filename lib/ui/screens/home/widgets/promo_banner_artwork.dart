part of 'promo_banner.dart';

/// Food picture with a soft shadow that follows its shape.
class _Food extends StatelessWidget {
  const _Food({required this.food});

  final PromoFood food;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: food.center.dx - food.size.width / 2,
      top: food.center.dy - food.size.height / 2,
      width: food.size.width,
      height: food.size.height,
      child: Transform.rotate(
        angle: food.degrees * math.pi / 180,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Transform.translate(
              offset: Offset(0, food.shadowOffset),
              child: ImageFiltered(
                imageFilter: ui.ImageFilter.blur(
                  sigmaX: food.shadowBlur,
                  sigmaY: food.shadowBlur,
                ),
                child: Image.asset(
                  food.imagePath,
                  fit: BoxFit.cover,
                  color: food.shadowColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ),
            Image.asset(food.imagePath, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({required this.star, required this.color});

  final PromoStar star;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: star.center.dx - star.size / 2,
      top: star.center.dy - star.size / 2,
      width: star.size,
      height: star.size,
      child: Transform.rotate(
        angle: star.degrees * math.pi / 180,
        child: CustomPaint(
          painter: _StarPainter(
            color.withValues(alpha: color.a * star.opacity),
          ),
        ),
      ),
    );
  }
}

/// Very faint white square rotated -30 degrees (2% opacity).
class _LightBand extends StatelessWidget {
  const _LightBand();

  static const _box = 308.808;
  static const _square = 226.063;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -139 + (_box - _square) / 2,
      top: -111 + (_box - _square) / 2,
      width: _square,
      height: _square,
      child: Transform.rotate(
        angle: -30 * math.pi / 180,
        child: const ColoredBox(color: Color(0x05FFFFFF)),
      ),
    );
  }
}

/// Rounded five point star (Figma "COCO/Bold/Star"), drawn in a 14.31 box.
class _StarPainter extends CustomPainter {
  const _StarPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 14.3084);
    final path = Path()
      ..moveTo(9.42526, 1.53089)
      ..cubicTo(8.57714, -0.510295, 5.73122, -0.510297, 4.8831, 1.53089)
      ..lineTo(4.43852, 2.60085)
      ..cubicTo(4.2615, 3.02688, 3.87577, 3.31658, 3.43488, 3.3665)
      ..lineTo(2.19426, 3.50697)
      ..cubicTo(0.0970425, 3.74443, -0.739822, 6.3552, 0.768116, 7.81306)
      ..lineTo(1.82147, 8.83144)
      ..cubicTo(2.13267, 9.1323, 2.27259, 9.5786, 2.18678, 10.0127)
      ..lineTo(1.93245, 11.299)
      ..cubicTo(1.5102, 13.4347, 3.81158, 15.1019, 5.666, 13.9113)
      ..lineTo(6.498, 13.3772)
      ..cubicTo(6.89954, 13.1194, 7.40881, 13.1194, 7.81035, 13.3772)
      ..lineTo(8.64235, 13.9113)
      ..cubicTo(10.4968, 15.1019, 12.7982, 13.4347, 12.3759, 11.299)
      ..lineTo(12.1216, 10.0127)
      ..cubicTo(12.0358, 9.5786, 12.1757, 9.1323, 12.4869, 8.83144)
      ..lineTo(13.5402, 7.81306)
      ..cubicTo(15.0482, 6.3552, 14.2113, 3.74443, 12.1141, 3.50697)
      ..lineTo(10.8735, 3.3665)
      ..cubicTo(10.4326, 3.31658, 10.0469, 3.02689, 9.86983, 2.60085)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_StarPainter oldDelegate) => oldDelegate.color != color;
}

/// Blurred circle, fading in towards the bottom, rotated 14.65 degrees.
class _GlowPainter extends CustomPainter {
  const _GlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 96.0552;
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(14.65 * math.pi / 180);

    // Gradient runs along the same axis as in Figma (circle-centred coords)
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
      ..shader = ui.Gradient.linear(
        const Offset(22.21, -100.26),
        const Offset(0, radius),
        const [Color(0x00FBD0B2), Color(0xCCF8CC9D)], // 80% opacity
      );
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(_GlowPainter oldDelegate) => false;
}

/// Cylinder: body with a curved top edge, a rim and a lighter top.
class _PodiumPainter extends CustomPainter {
  const _PodiumPainter(this.colors);

  final PodiumColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    // Body (Figma "Rectangle 73"), 127 x 49 starting 10 below the rim
    final body = Path()
      ..moveTo(0, 10)
      ..lineTo(31.4356, 15.65385)
      ..lineTo(62.8713, 17.53846)
      ..lineTo(95.5644, 15.65385)
      ..lineTo(127, 10)
      ..lineTo(127, 59)
      ..lineTo(0, 59)
      ..close();
    canvas.drawPath(body, Paint()..color = colors.body);

    // White inner shadow around the body edges
    canvas.save();
    canvas.clipPath(body);
    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = colors.innerShadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.restore();

    // Rim
    canvas.drawOval(
      const Rect.fromLTWH(0, 0, 127, 20),
      Paint()..color = colors.rim,
    );

    // Top surface with a faint shadow underneath
    const top = Rect.fromLTWH(5, 2, 117, 15);
    canvas.drawOval(
      top.shift(const Offset(0, 0.5)),
      Paint()..color = const Color(0x0D000000),
    );
    canvas.drawOval(top, Paint()..color = colors.top);
  }

  @override
  bool shouldRepaint(_PodiumPainter oldDelegate) =>
      oldDelegate.colors != colors;
}

/// Soft light beam fading out towards the top, drawn at 30% opacity.
class _BeamPainter extends CustomPainter {
  const _BeamPainter.back(this.color, this.fadeColor) : _front = false;
  const _BeamPainter.front(this.color, this.fadeColor) : _front = true;

  final Color color;
  final Color fadeColor;
  final bool _front;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path;
    final Offset from;
    final Offset to;

    if (_front) {
      // Figma "Vector 10", 215 x 60
      path = Path()
        ..moveTo(167.227, 60)
        ..lineTo(51.5637, 60)
        ..cubicTo(44.0205, 37.2365, 2.0303, 3.11192, 0.0187709, 1.10706)
        ..cubicTo(-1.99276, -0.897802, 158.216, 0.271502, 215, 1.10686)
        ..close();
      from = const Offset(103.109, 61.8792);
      to = const Offset(104.5, 5);
    } else {
      // Figma "Vector 9", 169 x 72
      path = Path()
        ..moveTo(141.787, 72)
        ..lineTo(25.341, 72)
        ..cubicTo(17.7467, 49.206, 2.05181, 3.11602, 0.026666, 1.10847)
        ..cubicTo(-1.99848, -0.899077, 111.832, 0.271993, 169, 1.10847)
        ..close();
      from = const Offset(77.2355, 73.8821);
      to = const Offset(77.2355, -0.146272);
    }

    final paint = Paint()
      ..shader = ui.Gradient.linear(from, to, [
        color.withValues(alpha: 0.3),
        fadeColor,
      ]);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BeamPainter oldDelegate) =>
      oldDelegate._front != _front ||
      oldDelegate.color != color ||
      oldDelegate.fadeColor != fadeColor;
}
