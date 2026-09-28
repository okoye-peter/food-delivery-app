import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// White card used by the home sections: a header with a title, optional
/// subtitle and trailing icon, then the section's content.
class HomeSectionCard extends StatelessWidget {
  const HomeSectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.titleSuffix,
    this.trailing,
    required this.child,
  });

  final String title;
  final String? subtitle;

  /// Shown right after the title, e.g. a countdown.
  final Widget? titleSuffix;

  /// Header action on the right, e.g. [HomeSectionChevron].
  final Widget? trailing;

  /// Section content below the header. Adds its own padding.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: context.colors.sectionTitle,
      ),
    );

    return Card(
      elevation: 0.8,
      // Card adds 4px on every side by default; line up with the other children
      margin: EdgeInsets.zero,
      color: context.colors.cardBackground,
      // M3 tints elevated cards with the primary colour; keep the exact fill
      surfaceTintColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsetsDirectional.only(
              start: 16,
              end: 14,
            ),
            // with a subtitle, pin the trailing icon to the top instead of
            // centring it on both lines
            titleAlignment: subtitle == null
                ? ListTileTitleAlignment.center
                : ListTileTitleAlignment.top,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleSuffix == null)
                  titleText
                else
                  // shrink the title and suffix together on narrow screens or
                  // large text instead of overflowing
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        titleText,
                        const SizedBox(width: 8),
                        ?titleSuffix,
                      ],
                    ),
                  ),
                if (subtitle != null) ...[
                  // subtitle is part of the title so this gap is exact
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: GoogleFonts.inter(
                      color: context.colors.sectionSubtitle,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
            trailing: trailing,
          ),
          child,
        ],
      ),
    );
  }
}

/// "See all" chevron for a [HomeSectionCard] header.
class HomeSectionChevron extends StatelessWidget {
  const HomeSectionChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.chevron_right, color: context.colors.chevron, size: 32);
  }
}
