import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Full width amber button used for the main action of a screen.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: colorScheme.onPrimary,
            fontWeight: const FontWeight(650),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
