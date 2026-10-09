import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// One past query: tap to search it again, or the close icon to remove it.
class RecentSearchTile extends StatelessWidget {
  const RecentSearchTile({
    super.key,
    required this.query,
    required this.onTap,
    required this.onRemove,
  });

  final String query;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      // ListTile already stretches the title to fill the row
      title: Text(
        query,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: context.colors.inputText,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: IconButton(
        // drop the default 48px minimum so the icon sits flush right
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(
          Icons.close,
          color: context.colors.inputText,
          size: 24,
        ),
        onPressed: onRemove,
      ),
    );
  }
}
