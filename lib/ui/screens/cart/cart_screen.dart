import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/repositories/cart_repository.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/price_summary.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/ui/screens/cart/widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final clear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear cart?'),
        content: const Text('All meals will be removed from your cart.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (clear ?? false) CartRepository.instance.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartRepository.instance;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) => Scaffold(
        appBar: PageAppBar(
          title: 'My cart',
          actions: [
            if (!cart.isEmpty)
              TextButton(
                onPressed: () => _confirmClear(context),
                child: Text(
                  'Clear',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: context.colors.link,
                  ),
                ),
              ),
          ],
        ),
        body: cart.isEmpty
            ? EmptyState(
                icon: Icons.shopping_bag_outlined,
                title: 'Your cart is empty',
                message:
                    'Add a few meals from the menu and they will show up here.',
                actionLabel: 'Browse menu',
                onAction: () => context.go(AppRoutes.menu),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: cart.items.length,
                separatorBuilder: (_, _) =>
                    Divider(height: 28, color: context.colors.divider),
                itemBuilder: (_, index) {
                  final item = cart.items[index];
                  return Dismissible(
                    key: ValueKey(item.product.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => cart.remove(item.product.id),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5484D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                    child: CartItemTile(
                      item: item,
                      onQuantityChanged: (quantity) =>
                          cart.setQuantity(item.product.id, quantity),
                    ),
                  );
                },
              ),
        bottomNavigationBar: cart.isEmpty
            ? null
            : _CheckoutBar(subtotal: cart.subtotal),
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.subtotal});

  final double subtotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PriceSummary(
                subtotal: subtotal,
                deliveryFee: OrderRepository.deliveryFee,
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: 'Checkout',
                onPressed: () => context.push(AppRoutes.checkout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
