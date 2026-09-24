import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/screens/onboarding/onboarding_colors.dart';
import 'package:yummy/ui/screens/onboarding/widgets/onboarding_pill.dart';

class InfoPill extends StatelessWidget {
  const InfoPill({super.key, required this.svgAsset, required this.label});

  final String svgAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OnboardingPill(
      padding: const EdgeInsets.fromLTRB(7, 7, 16, 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: onboardingRed,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(svgAsset, width: 14, height: 14),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 42, 42, 42),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
