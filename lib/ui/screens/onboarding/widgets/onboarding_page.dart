import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yummy/data/models/onboarding_page_data.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;
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
