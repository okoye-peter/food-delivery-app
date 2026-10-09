import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/data/repositories/product_repository.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/cart_button.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/core/widgets/quantity_stepper.dart';
import 'package:yummy/ui/core/widgets/rating_label.dart';
import 'package:yummy/ui/core/widgets/save_button.dart';
import 'package:yummy/ui/screens/home/widgets/promo_badge.dart';
import 'package:yummy/utils/formatters.dart';

/// One meal: big picture, details, and a quantity picker to add it to the
/// cart.
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final _product = ProductRepository.instance.findById(widget.productId);
  var _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = _product;
    if (product == null) {
      return const Scaffold(
        appBar: PageAppBar(title: ''),
        body: EmptyState(
          icon: Icons.no_food_outlined,
          title: 'Meal not found',
          message: 'It may no longer be on the menu.',
        ),
      );
    }

    final background = ProductImageTile.colorFor(product.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: background,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                tooltip: 'Back',
                onPressed: () => context.pop(),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                icon: const Icon(Icons.chevron_left, color: Color(0xFF313337)),
              ),
            ),
            actions: [
              SaveButton(product: product, size: 40),
              const SizedBox(width: 12),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 56, 40, 24),
                  child: Image.asset(product.image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: _Details(product: product)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              QuantityStepper(
                quantity: _quantity,
                onChanged: (value) => setState(() => _quantity = value),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  label: 'Add · ${formatPrice(product.price * _quantity)}',
                  onPressed: () {
                    addToCart(context, product, quantity: _quantity);
                    setState(() => _quantity = 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final distance = product.distanceKm;
    // TODO: every product should come with a description from the API
    final description =
        product.description ??
        'Made to order by our partner kitchens and delivered hot to your '
            'door.';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.category.name.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: context.colors.inputLabel,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: context.colors.sectionTitle,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              RatingLabel(
                rating: product.rating,
                count: product.ratingCount,
                fontSize: 14,
              ),
              if (distance != null)
                _InfoChip(
                  icon: Icons.location_on_outlined,
                  label: '${distance}km',
                ),
              const _InfoChip(icon: Icons.schedule, label: '25–35 min'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatPrice(product.price),
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: context.colors.sectionTitle,
                ),
              ),
              if (product.isOnPromo) ...[
                const SizedBox(width: 10),
                Text(
                  formatPrice(product.originalPrice!),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.colors.inputLabel,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: context.colors.inputLabel,
                  ),
                ),
                const SizedBox(width: 10),
                PromoBadge(label: '-${product.discountPercent}%'),
              ],
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'About this meal',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.colors.sectionTitle,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: context.colors.subtitle,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: context.colors.searchFill,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.delivery_dining, color: context.colors.inputText),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Delivery fee ${formatPrice(OrderRepository.deliveryFee)}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.colors.inputText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: context.colors.inputText),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: context.colors.inputText,
          ),
        ),
      ],
    );
  }
}
