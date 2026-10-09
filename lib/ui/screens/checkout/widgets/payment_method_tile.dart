import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

IconData paymentMethodIcon(PaymentMethod method) => switch (method) {
  PaymentMethod.cash => Icons.payments_outlined,
  PaymentMethod.card => Icons.credit_card,
  PaymentMethod.wallet => Icons.account_balance_wallet_outlined,
};

/// Selectable payment option with a radio-style ring on the right.
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(paymentMethodIcon(method), color: context.colors.inputText),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  method.label,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: context.colors.sectionTitle,
                  ),
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? primary : context.colors.inputLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
