import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

const _starGold = Color(0xFFFFD166);
const _starAmber = Color(0xFFFEA159);
const _starColors = [
  _starGold,
  Color.fromRGBO(255, 209, 102, 1),
  _starGold,
  _starAmber,
  _starGold,
];
const _accentBlue = Color.fromARGB(255, 125, 168, 252);
const _accentRed = Color.fromARGB(255, 255, 88, 109);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  static final _pages = [
    _OnboardingPageData(
      imageAsset: 'assets/images/onboarding/onboarding_1.png',
      title: 'Delivery everywhere',
      description: 'We are always ready to deliver your items quickly and professionally',
      bannerColors: const [
        Color.fromARGB(140, 125, 168, 252),
        Color.fromARGB(160, 245, 232, 224),
        Color.fromARGB(190, 254, 208, 117),
      ],
      topLeftBadgeBuilder: (context) =>
          const _RatingBadge(starColors: _starColors, accentColor: _accentBlue),
      accentBadgeBuilder: (context) =>
          const _LocationBadge(accentColor: _accentBlue),
    ),

    _OnboardingPageData(
      imageAsset: 'assets/images/onboarding/onboarding_2.png',
      title: 'Fast food delivery',
      description: 'We are always ready to deliver your items quickly and professionally',
      bannerColors: const [
        Color.fromARGB(190, 254, 208, 117),
        Color.fromARGB(160, 245, 232, 224),
        Color.fromARGB(140, 125, 168, 252),
      ],
      topLeftBadgeBuilder: (context) =>
          const _InfoPill(svgAsset: 'assets/svg/onboarding/clock.svg', label: '15 min'),
      accentBadgeBuilder: (context) => const _AccentIconBadge(
        svgAsset: 'assets/svg/onboarding/bolt.svg',
        color: _accentRed,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (context, index) => _OnboardingPage(
          data: _pages[index],
          pageIndex: index,
          pageCount: _pages.length,
          pageController: _pageController,
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.bannerColors,
    required this.topLeftBadgeBuilder,
    required this.accentBadgeBuilder,
    this.topLeftBadgeTop = 0.33,
    this.accentBadgeTop = 0.55,
    this.accentBadgeRight = 30,
  });

  final String imageAsset;
  final String title;
  final String description;
  final List<Color> bannerColors;
  final WidgetBuilder topLeftBadgeBuilder;
  final WidgetBuilder accentBadgeBuilder;

  /// Badge offsets from the top, as fractions of the banner height.
  final double topLeftBadgeTop;
  final double accentBadgeTop;
  final double accentBadgeRight;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.data,
    required this.pageIndex,
    required this.pageCount,
    required this.pageController,
  });

  final _OnboardingPageData data;
  final int pageIndex;
  final int pageCount;
  final PageController pageController;

  bool get _isLastPage => pageIndex == pageCount - 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    final bannerHeight = (size.height * 0.36).clamp(240.0, 340.0);
    final imageWidth = (size.width * 0.9).clamp(220.0, 420.0);

    return SizedBox.expand(
      child: Stack(
        children: [
          _buildBanner(bannerHeight, data.bannerColors),

          Positioned(
            top: topPadding + bannerHeight * 0.32,
            left: 40,
            child: SvgPicture.asset(
              'assets/svg/onboarding/onboarding line curve.svg',
              width: size.width,
            ),
          ),

          Positioned(
            top: topPadding + bannerHeight * 0.3,
            left: 15,
            right: 20,
            child: Center(
              child: Image.asset(
                data.imageAsset,
                width: imageWidth,
                cacheWidth: (imageWidth * devicePixelRatio).round(),
              ),
            ),
          ),

          Positioned(
            top: topPadding + bannerHeight * data.topLeftBadgeTop,
            left: 20,
            child: data.topLeftBadgeBuilder(context),
          ),

          Positioned(
            top: topPadding + bannerHeight * data.accentBadgeTop,
            right: data.accentBadgeRight,
            child: data.accentBadgeBuilder(context),
          ),

          Positioned(
            bottom: bottomPadding + 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
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
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          for (var dot = 0; dot < pageCount; dot++)
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Container(
                                width: dot == pageIndex ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: dot == pageIndex
                                      ? const Color.fromARGB(255, 254, 161, 89)
                                      : const Color.fromARGB(
                                          255,
                                          218,
                                          218,
                                          218,
                                        ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      IconButton.filled(
                        onPressed: () {
                          if (_isLastPage) return;
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(
                          _isLastPage
                              ? CupertinoIcons.check_mark
                              : CupertinoIcons.chevron_right,
                          color: Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: _starAmber,
                          minimumSize: const Size(55, 55),
                          shape: const CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(double height, List<Color> colors) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black, Colors.black, Colors.transparent],
        stops: [0.0, 0.3, 1.0],
      ).createShader(bounds),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
            stops: const [0.0, 0.3, 0.75],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPill extends StatelessWidget {
  const _OnboardingPill({
    required this.child,
    this.padding = const EdgeInsets.all(9),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(999)),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.starColors, required this.accentColor});

  final List<Color> starColors;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return _OnboardingPill(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
            ),
            height: 28,
            width: 28,
          ),
          const SizedBox(width: 13),
          for (final starColor in starColors)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SvgPicture.asset(
                'assets/svg/onboarding/star.svg',
                colorFilter: ColorFilter.mode(starColor, BlendMode.srcIn),
                width: 16,
                height: 16,
              ),
            ),
        ],
      ),
    );
  }
}

class _LocationBadge extends StatelessWidget {
  const _LocationBadge({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return _OnboardingPill(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
        padding: const EdgeInsets.all(6),
        child: const Icon(Icons.location_pin, color: Colors.white, size: 25),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.svgAsset, required this.label});

  final String svgAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return _OnboardingPill(
      padding: const EdgeInsets.fromLTRB(7, 7, 16, 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _accentRed,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(svgAsset, width: 14, height: 14),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 42, 42, 42),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccentIconBadge extends StatelessWidget {
  const _AccentIconBadge({required this.svgAsset, required this.color});

  final String svgAsset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return _OnboardingPill(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: SvgPicture.asset(svgAsset, width: 16, height: 19),
      ),
    );
  }
}
