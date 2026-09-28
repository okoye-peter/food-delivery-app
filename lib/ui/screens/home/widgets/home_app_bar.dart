import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// Home header: "Delivery to" address dropdown on the left, bag and menu
/// buttons on the right. Must be placed inside a [CustomScrollView].
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.deliveryAddress,
    required this.savedAddresses,
    required this.onDeliveryAddressChanged,
    this.onAddAddressTap,
    this.onBagTap,
    this.onMenuTap,
  });

  final String deliveryAddress;
  final List<String> savedAddresses;
  final ValueChanged<String> onDeliveryAddressChanged;

  /// Shows an "Add new address" item at the bottom of the dropdown when set.
  final VoidCallback? onAddAddressTap;
  final VoidCallback? onBagTap;
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
      title: MenuAnchor(
        alignmentOffset: const Offset(0, 8),
        menuChildren: [
          for (final address in savedAddresses)
            MenuItemButton(
              leadingIcon: Icon(
                Icons.location_on_outlined,
                color: context.colors.inputText,
              ),
              trailingIcon: address == deliveryAddress
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onPressed: () => onDeliveryAddressChanged(address),
              child: Text(
                address,
                style: GoogleFonts.inter(color: context.colors.inputText),
              ),
            ),
          if (onAddAddressTap != null) ...[
            const Divider(height: 1),
            MenuItemButton(
              leadingIcon: Icon(Icons.add, color: context.colors.link),
              onPressed: onAddAddressTap,
              child: Text(
                'Add new address',
                style: GoogleFonts.inter(color: context.colors.link),
              ),
            ),
          ],
        ],
        builder: (_, controller, child) => GestureDetector(
          // opaque: the gaps between icon and text are tappable too
          behavior: HitTestBehavior.opaque,
          onTap: () =>
              controller.isOpen ? controller.close() : controller.open(),
          child: child,
        ),
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
        IconButton(
          onPressed: onBagTap,
          icon: SvgPicture.asset(
            'assets/svg/dashboard/bag.svg',
            width: 24,
            colorFilter: iconColorFilter,
          ),
        ),
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
