import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// Looks like a search input but only opens the search screen, where the
/// actual typing happens.
class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    // No underline from the theme, just the rounded fill
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );

    return Semantics(
      button: true,
      label: 'Search food, restaurant',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push(AppRoutes.search),
        // the field is display only, so it never takes focus or the keyboard
        child: AbsorbPointer(
          child: TextField(
            readOnly: true,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: context.colors.inputText,
            ),
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
          ),
        ),
      ),
    );
  }
}
