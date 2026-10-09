import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// The search input shown in the search screen's app bar.
class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller, this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    // No underline from the theme, just the rounded fill
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );

    return TextField(
      controller: controller,
      // the user tapped search on home, so open ready to type
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: context.colors.inputText,
      ),
      cursorColor: context.colors.inputText,
      decoration: InputDecoration(
        hintText: 'Search food, restaurant,...',
        hintStyle: GoogleFonts.inter(
          color: context.colors.searchHint,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: context.colors.searchIcon,
          size: 20,
        ),
        // pulls the hint closer to the icon (default slot is 48px wide)
        prefixIconConstraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 40,
        ),
        filled: true,
        fillColor: context.colors.searchFill,
        isDense: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
