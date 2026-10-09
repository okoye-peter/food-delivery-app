import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/data/repositories/cart_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// Bag icon that opens the cart, with a badge counting the portions in it.
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cart = CartRepository.instance;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) => IconButton(
        tooltip: 'Cart',
        onPressed: () => context.push(AppRoutes.cart),
        icon: Badge(
          isLabelVisible: cart.itemCount > 0,
          label: Text('${cart.itemCount}'),
          backgroundColor: colorScheme.primary,
          textColor: colorScheme.onPrimary,
          child: SvgPicture.asset(
            'assets/svg/dashboard/bag.svg',
            width: 24,
            // tint so the icon stays visible in dark mode
            colorFilter: ColorFilter.mode(
              context.colors.inputText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

/// Adds [product] to the cart and confirms it with a "View cart" snack bar.
void addToCart(BuildContext context, ProductModel product, {int quantity = 1}) {
  CartRepository.instance.add(product, quantity: quantity);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        // snack bars with an action stay up by default; this one is just a
        // confirmation
        persist: false,
        content: Text(
          '${quantity > 1 ? '$quantity × ' : ''}${product.name} added to cart',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        action: SnackBarAction(
          label: 'View cart',
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ),
    );
}
