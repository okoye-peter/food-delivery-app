import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// Bottom navigation around the signed-in tabs: Home, Menu, Saved, Orders.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final orders = OrderRepository.instance;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: context.colors.cardBackground,
          surfaceTintColor: Colors.transparent,
          indicatorColor: primary.withValues(alpha: 0.2),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => GoogleFonts.inter(
              fontSize: 12,
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: context.colors.inputText,
            ),
          ),
          iconTheme: WidgetStatePropertyAll(
            IconThemeData(color: context.colors.inputText),
          ),
        ),
        child: ListenableBuilder(
          listenable: orders,
          builder: (context, _) => NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            // tapping the current tab again goes back to its first screen
            onDestinationSelected: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.restaurant_menu_outlined),
                selectedIcon: Icon(Icons.restaurant_menu),
                label: 'Menu',
              ),
              const NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'Saved',
              ),
              NavigationDestination(
                // dot while an order is on its way
                icon: Badge(
                  isLabelVisible: orders.activeOrders.isNotEmpty,
                  backgroundColor: primary,
                  child: const Icon(Icons.receipt_long_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: orders.activeOrders.isNotEmpty,
                  backgroundColor: primary,
                  child: const Icon(Icons.receipt_long),
                ),
                label: 'Orders',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
