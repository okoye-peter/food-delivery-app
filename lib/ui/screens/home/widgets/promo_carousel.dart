import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yummy/ui/screens/home/widgets/promo_banner.dart';

class PromoItem {
  const PromoItem({required this.title, required this.style});

  final String title;
  final PromoBannerStyle style;
}

// TODO: load promos from the API
const homePromos = [
  PromoItem(
    title: 'Delicious noodles with discount',
    style: PromoBannerStyle.orange,
  ),
  PromoItem(title: 'Beverage Discount Code', style: PromoBannerStyle.grey),
];

/// Swipeable row of [PromoBanner]s. Takes the full screen width and adds
/// the page gutter itself, so neighbouring banners stay off screen.
///
/// Moves to the next banner every [autoScrollInterval], wrapping back to the
/// first. The timer pauses while the user is swiping and restarts after.
class PromoCarousel extends StatefulWidget {
  const PromoCarousel({
    super.key,
    required this.promos,
    this.horizontalPadding = 12,
    this.autoScrollInterval = const Duration(seconds: 8),
    this.onPromoTap,
  });

  final List<PromoItem> promos;
  final double horizontalPadding;
  final Duration autoScrollInterval;
  final ValueChanged<PromoItem>? onPromoTap;

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final _controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (widget.promos.length < 2) return;
    _timer = Timer.periodic(widget.autoScrollInterval, (_) => _nextPage());
  }

  void _nextPage() {
    if (!_controller.hasClients) return;
    final current = _controller.page?.round() ?? 0;
    final next = (current + 1) % widget.promos.length;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool _onScroll(ScrollNotification notification) {
    // Only a finger drag has dragDetails; our own animateToPage does not
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _timer?.cancel();
    } else if (notification is ScrollEndNotification) {
      _startTimer();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final promos = widget.promos;
    final horizontalPadding = widget.horizontalPadding;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bannerWidth = constraints.maxWidth - horizontalPadding * 2;

        return SizedBox(
          // A horizontal list needs a fixed height
          height: bannerWidth / PromoBanner.defaultAspectRatio,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: PageView.builder(
              key: const PageStorageKey('home-promos'),
              controller: _controller,
              // Let the food and shadow draw outside the banner (the grey
              // banner's basket sticks out above the top edge)
              clipBehavior: Clip.none,
              itemCount: promos.length,
              itemBuilder: (context, index) {
                final promo = promos[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: PromoBanner(
                    title: promo.title,
                    style: promo.style,
                    onTap: widget.onPromoTap == null
                        ? null
                        : () => widget.onPromoTap!(promo),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
