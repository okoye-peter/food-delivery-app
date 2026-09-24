import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yummy/ui/screens/onboarding/widgets/onboarding_pill.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({
    super.key,
    required this.starColors,
    required this.accentColor,
  });

  final List<Color> starColors;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return OnboardingPill(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
            ),
            height: 28,
            width: 28,
          ),
          const SizedBox(width: 13),
          for (final starColor in starColors)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SvgPicture.asset(
                'assets/svg/onboarding/star.svg',
                colorFilter: ColorFilter.mode(starColor, BlendMode.srcIn),
                width: 16,
                height: 16,
              ),
            ),
        ],
      ),
    );
  }
}
