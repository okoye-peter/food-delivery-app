import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/cart_button.dart';

/// Home header: tappable "Delivery to" address on the left, bag and menu
/// buttons on the right. Must be placed inside a [CustomScrollView].
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.deliveryAddress,
    required this.onDeliveryAddressTap,
    this.onMenuTap,
  });

  final String deliveryAddress;
  final VoidCallback onDeliveryAddressTap;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    // Tint so the icons stay visible in dark mode
    final iconColorFilter = ColorFilter.mode(
      context.colors.inputText,
      BlendMode.srcIn,
    );

    return SliverAppBar(
      floating: true,
      toolbarHeight: 64,
      titleSpacing: 12,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      title: GestureDetector(
        // opaque: the gaps between icon and text are tappable too
        behavior: HitTestBehavior.opaque,
        onTap: onDeliveryAddressTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/svg/dashboard/location.svg', width: 28),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery to',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: context.colors.inputLabel,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          deliveryAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colors.inputText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: context.colors.inputText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        const CartButton(),
        IconButton(
          onPressed: onMenuTap,
          icon: SvgPicture.asset(
            'assets/svg/dashboard/sidebar_toggle.svg',
            width: 24,
            colorFilter: iconColorFilter,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
