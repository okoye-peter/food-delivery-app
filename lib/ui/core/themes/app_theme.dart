import 'package:flutter/material.dart';
import 'app_colors.dart';

// Brand amber (same as the onboarding next button). Seeding from white made
// Flutter fall back to a teal palette for buttons, fields and checkboxes.
const _brandAmber = Color(0xFFFEA159);
const _onBrandAmber = Color(0xFF2B2A32); // dark text on amber buttons, as in the design
const _darkBackground = Color(0xFF2B2A32);

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandAmber,
      // fromSeed darkens the seed for contrast; pin the real brand color instead
      primary: _brandAmber,
      onPrimary: _onBrandAmber,
      surface: Colors.white,
      // Neutral grays for cards/sheets instead of the generated peach tint
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF8F8F9),
      surfaceContainer: const Color(0xFFF3F3F5),
      surfaceContainerHigh: const Color(0xFFEDEDF0),
      surfaceContainerHighest: const Color(0xFFE7E7EB),
    ),
    extensions: const [AppColors.light],
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandAmber,
      brightness: Brightness.dark,
      primary: _brandAmber,
      onPrimary: _onBrandAmber,
      surface: _darkBackground, // cards, sheets, dialogs, app bar match the page
      // Steps up from #2B2A32 so raised surfaces read as lighter, not brown
      surfaceContainerLowest: const Color(0xFF242329),
      surfaceContainerLow: const Color(0xFF302F37),
      surfaceContainer: const Color(0xFF35343C),
      surfaceContainerHigh: const Color(0xFF3B3A43),
      surfaceContainerHighest: const Color(0xFF42414A),
    ),
    extensions: const [AppColors.dark],
  );
}
