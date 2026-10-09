import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// App bar with a bold title and, on pushed screens, a chevron back button.
class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
    this.bottom,
  });

  final String title;

  /// False on the bottom navigation tabs, which have nothing to go back to.
  final bool showBack;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      titleSpacing: showBack ? 0 : 16,
      leading: showBack
          ? IconButton(
              tooltip: 'Back',
              // opened with go (e.g. after checkout) there may be nothing to
              // pop; fall back to home
              onPressed: () => context.canPop()
                  ? context.pop()
                  : context.go(AppRoutes.dashboard),
              icon: Icon(
                Icons.chevron_left,
                size: 28,
                color: context.colors.inputText,
              ),
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: context.colors.inputText,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      actions: [...?actions, const SizedBox(width: 4)],
      bottom: bottom,
    );
  }
}
