import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/curved_bottom_clipper.dart';

/// Page shell shared by the auth flow screens: the curved gradient header
/// (title, subtitle, food image, optional back button) followed by the
/// form [body] and the [footer] actions pinned towards the bottom.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.footer,
    this.imagePath = 'assets/images/authentication/sign in food.png',
    this.showBackButton = true,
  });

  static const maxContentWidth = 480.0;

  final String title;
  final String subtitle;
  final List<Widget> body;
  final List<Widget> footer;
  final String? imagePath;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final screenHeight = MediaQuery.heightOf(context);
    final screenWidth = MediaQuery.widthOf(context);

    // Extra room over the sign in header for the back button row.
    final headerHeight = math.max(
      topPadding + 170,
      math.min(screenHeight * 0.3, 320.0),
    );
    final contentWidth = math.min(screenWidth, maxContentWidth);
    final imageWidth = math.min(
      (contentWidth * 0.42).clamp(120.0, 220.0),
      headerHeight,
    );
    // On tall screens keep the buttons grouped with the form instead of
    // pushing them to the bottom edge.
    final isTallScreen = screenHeight > 900;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: const CurvedBottomClipper(curveDepth: 25),
                  child: Container(
                    width: double.infinity,
                    height: headerHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          context.colors.headerBlue,
                          context.colors.headerYellow,
                        ],
                        stops: const [0.05, 0.75],
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: maxContentWidth,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (imagePath != null)
                              Positioned(
                                top: topPadding + 40,
                                right: -28,
                                child: Image.asset(
                                  imagePath!,
                                  width: imageWidth,
                                ),
                              ),

                            if (showBackButton)
                              Positioned(
                                top: topPadding + 4,
                                left: 4,
                                child: IconButton(
                                  onPressed: () => context.pop(),
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: context.colors.title,
                                  ),
                                ),
                              ),

                            Positioned(
                              top: topPadding + 60,
                              left: 15,
                              child: SizedBox(
                                width: contentWidth * 0.6,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: GoogleFonts.lato(
                                        color: context.colors.title,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      subtitle,
                                      softWrap: true,
                                      style: GoogleFonts.lato(
                                        color: context.colors.subtitle,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: maxContentWidth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          15,
                          0,
                          15,
                          bottomPadding + 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...body,
                            isTallScreen
                                ? const SizedBox(height: 40)
                                : const Spacer(),
                            ...footer,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
