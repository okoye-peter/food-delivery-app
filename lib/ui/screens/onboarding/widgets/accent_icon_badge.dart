import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yummy/ui/screens/onboarding/widgets/onboarding_pill.dart';

class AccentIconBadge extends StatelessWidget {
  const AccentIconBadge({
    super.key,
    required this.svgAsset,
    required this.color,
  });

  final String svgAsset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OnboardingPill(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: SvgPicture.asset(svgAsset, width: 16, height: 19),
      ),
    );
  }
}
