import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// "Recent search" label with the "Clear all" action on the right.
class RecentSearchHeader extends StatelessWidget {
  const RecentSearchHeader({super.key, required this.onClearAll});

  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.inter(
      fontSize: 14,
      color: context.colors.inputLabel,
      fontWeight: FontWeight.w500,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Recent search', style: style),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 20),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          onPressed: onClearAll,
          child: Text('Clear all', style: style),
        ),
      ],
    );
  }
}
