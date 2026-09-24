import 'package:flutter/material.dart';
import 'package:yummy/data/models/onboarding_page_data.dart';
import 'package:yummy/ui/core/themes/app_theme.dart';
import 'package:yummy/ui/screens/onboarding/onboarding_colors.dart';
import 'package:yummy/ui/screens/onboarding/widgets/accent_icon_badge.dart';
import 'package:yummy/ui/screens/onboarding/widgets/info_pill.dart';
import 'package:yummy/ui/screens/onboarding/widgets/location_badge.dart';
import 'package:yummy/ui/screens/onboarding/widgets/onboarding_footer.dart';
import 'package:yummy/ui/screens/onboarding/widgets/onboarding_page.dart';
import 'package:yummy/ui/screens/onboarding/widgets/rating_badge.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  static final _pages = [
    OnboardingPageData(
      imageAsset: 'assets/images/onboarding/onboarding_1.png',
      title: 'Delivery everywhere',
      description: 'We are always ready to deliver your items quickly and professionally',
      bannerColors: const [
        Color.fromARGB(140, 125, 168, 252),
        Color.fromARGB(160, 245, 232, 224),
        Color.fromARGB(190, 254, 208, 117),
      ],
      topLeftBadgeBuilder: (context) => const RatingBadge(
        starColors: onboardingStarColors,
        accentColor: onboardingBlue,
      ),
      accentBadgeBuilder: (context) =>
          const LocationBadge(accentColor: onboardingBlue),
    ),

    OnboardingPageData(
      imageAsset: 'assets/images/onboarding/onboarding_2.png',
      title: 'Fast food delivery',
      description: 'We are always ready to deliver your items quickly and professionally',
      bannerColors: const [
        Color.fromARGB(190, 254, 208, 117),
        Color.fromARGB(160, 245, 232, 224),
        Color.fromARGB(140, 125, 168, 252),
      ],
      topLeftBadgeBuilder: (context) => const InfoPill(
        svgAsset: 'assets/svg/onboarding/clock.svg',
        label: '15 min',
      ),
      accentBadgeBuilder: (context) => const AccentIconBadge(
        svgAsset: 'assets/svg/onboarding/bolt.svg',
        color: onboardingRed,
      ),
      topLeftBadgeTop: 0.36,
      accentBadgeTop: 0.2,
      accentBadgeRight: 23,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Onboarding is designed for light mode only, so it ignores the system dark setting
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              itemBuilder: (context, index) =>
                  OnboardingPage(data: _pages[index]),
            ),
            Positioned(
              bottom: MediaQuery.paddingOf(context).bottom + 60,
              left: 0,
              right: 0,
              child: OnboardingFooter(
                pages: _pages,
                pageController: _pageController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
