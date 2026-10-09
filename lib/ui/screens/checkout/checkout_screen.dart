import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/models/voucher_model.dart';
import 'package:yummy/data/repositories/cart_repository.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/price_summary.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/ui/core/widgets/titled_card.dart';
import 'package:yummy/ui/screens/checkout/widgets/payment_method_tile.dart';
import 'package:yummy/utils/formatters.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const _gap = SizedBox(height: 14);

  final _cart = CartRepository.instance;
  final _noteController = TextEditingController();

  // TODO: share the selected address with the home screen
  var _address = '92 Hang Trong';
  var _paymentMethod = PaymentMethod.cash;
  VoucherModel? _voucher;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _changeAddress() async {
    final address = await context.push<String>(AppRoutes.address);
    if (address != null) setState(() => _address = address);
  }

  Future<void> _pickVoucher() async {
    // TODO: load the user's vouchers from the API
    final available = vouchers.where((v) => v.isAvailable).toList();
    final picked = await showModalBottomSheet<VoucherModel>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.colors.cardBackground,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 12),
          children: [
            for (final voucher in available)
              ListTile(
                leading: Icon(
                  Icons.confirmation_number_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  '${voucher.discount} off',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: context.colors.sectionTitle,
                  ),
                ),
                subtitle: Text(
                  '${voucher.code} · ${voucher.remaining} left',
                  style: GoogleFonts.inter(color: context.colors.subtitle),
                ),
                trailing: _voucher?.id == voucher.id
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () => Navigator.pop(context, voucher),
              ),
          ],
        ),
      ),
    );
    if (picked != null) setState(() => _voucher = picked);
  }

  void _placeOrder() {
    final order = OrderRepository.instance.place(
      items: _cart.items,
      deliveryAddress: _address,
      paymentMethod: _paymentMethod,
      voucher: _voucher,
      note: _noteController.text,
    );
    _cart.clear();
    // replaces cart and checkout, so back from tracking goes to the orders
    context.go(AppRoutes.orderDetail(order.id));
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = _cart.subtotal;
    final discount = _voucher?.discountOn(subtotal) ?? 0;
    const deliveryFee = OrderRepository.deliveryFee;
    final total = subtotal + deliveryFee - discount;

    if (_cart.isEmpty) {
      return const Scaffold(
        appBar: PageAppBar(title: 'Checkout'),
        body: EmptyState(
          icon: Icons.shopping_bag_outlined,
          title: 'Your cart is empty',
          message: 'Add some meals before checking out.',
        ),
      );
    }

    return Scaffold(
      appBar: const PageAppBar(title: 'Checkout'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          TitledCard(
            title: 'Deliver to',
            trailing: _LinkButton(label: 'Change', onPressed: _changeAddress),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/dashboard/location.svg',
                  width: 26,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _address,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: context.colors.sectionTitle,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Arrives in about 25–35 min',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: context.colors.subtitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _gap,

          TitledCard(
            title: 'Order summary (${_cart.itemCount})',
            trailing: _LinkButton(
              label: 'Edit',
              onPressed: () => context.pop(),
            ),
            child: Column(
              children: [
                for (final item in _cart.items)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          '${item.quantity}×',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item.product.name,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.colors.sectionTitle,
                            ),
                          ),
                        ),
                        Text(
                          formatPrice(item.total),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.colors.sectionTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _gap,

          TitledCard(
            title: 'Payment method',
            child: Column(
              children: [
                for (final method in PaymentMethod.values)
                  PaymentMethodTile(
                    method: method,
                    selected: _paymentMethod == method,
                    onTap: () => setState(() => _paymentMethod = method),
                  ),
              ],
            ),
          ),
          _gap,

          TitledCard(
            title: 'Voucher',
            trailing: _voucher == null
                ? null
                : _LinkButton(
                    label: 'Remove',
                    onPressed: () => setState(() => _voucher = null),
                  ),
            child: InkWell(
              onTap: _pickVoucher,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.searchFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _voucher == null
                            ? 'Add a voucher'
                            : '${_voucher!.code} · -${formatPrice(discount)}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: context.colors.inputText,
                        ),
                      ),
                    ),
                    Icon(Icons.chevron_right, color: context.colors.chevron),
                  ],
                ),
              ),
            ),
          ),
          _gap,

          TitledCard(
            title: 'Note for the restaurant',
            child: TextField(
              controller: _noteController,
              maxLines: 3,
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: context.colors.inputText,
              ),
              decoration: InputDecoration(
                hintText: 'E.g. no pepper, extra napkins',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: context.colors.searchHint,
                ),
                filled: true,
                fillColor: context.colors.searchFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          _gap,

          TitledCard(
            title: 'Payment summary',
            child: PriceSummary(
              subtotal: subtotal,
              deliveryFee: deliveryFee,
              discount: discount,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: PrimaryButton(
            label: 'Place order · ${formatPrice(total)}',
            onPressed: _placeOrder,
          ),
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(0, 28),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: context.colors.link,
        ),
      ),
    );
  }
}
