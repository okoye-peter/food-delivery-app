import 'dart:ui' show lerpDouble;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/onboarding_page_data.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/screens/onboarding/onboarding_colors.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.pages,
    required this.pageController,
  });

  final List<OnboardingPageData> pages;
  final PageController pageController;

  static const _inactiveDotColor = Color.fromARGB(255, 218, 218, 218);
  static const _activeDotColor = Color.fromARGB(255, 254, 161, 89);

  double get _page {
    if (!pageController.hasClients ||
        !pageController.position.haveDimensions) {
      return pageController.initialPage.toDouble();
    }
    return pageController.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        final page = _page;
        final index = page.round().clamp(0, pages.length - 1);
        final data = pages[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                layoutBuilder: (current, previous) => Stack(
                  alignment: Alignment.bottomLeft,
                  children: [...previous, ?current],
                ),
                child: Column(
                  key: ValueKey(index),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      softWrap: true,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 42, 42, 42),
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      data.description,
                      softWrap: true,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF8F8F8F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      for (var dot = 0; dot < pages.length; dot++)
                        _buildDot(
                          (1 - (page - dot).abs()).clamp(0.0, 1.0),
                        ),
                    ],
                  ),
                  IconButton.filled(
                    onPressed: () {
                      if (index == pages.length - 1) {
                        context.replace(AppRoutes.signIn);
                        return;
                      }
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_right,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: onboardingAmber,
                      minimumSize: const Size(55, 55),
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// [t] is 1 when this dot's page is fully shown, 0 when it's a page or more
  /// away, so the pill stretches/shrinks continuously as the page is dragged.
  Widget _buildDot(double t) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        width: lerpDouble(8, 25, t),
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: Color.lerp(_inactiveDotColor, _activeDotColor, t),
        ),
      ),
    );
  }
}
