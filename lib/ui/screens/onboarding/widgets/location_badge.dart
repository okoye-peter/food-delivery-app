import 'package:flutter/material.dart';
import 'package:yummy/ui/screens/onboarding/widgets/onboarding_pill.dart';

class LocationBadge extends StatelessWidget {
  const LocationBadge({super.key, required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return OnboardingPill(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
        padding: const EdgeInsets.all(6),
        child: const Icon(Icons.location_pin, color: Colors.white, size: 25),
      ),
    );
  }
}
