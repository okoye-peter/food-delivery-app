import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummy/data/models/voucher_model.dart';
import 'package:yummy/ui/screens/home/widgets/voucher_card.dart';

/// Two-column grid of [VoucherCard]s. Tapping an available voucher copies
/// its code.
class VoucherGrid extends StatelessWidget {
  const VoucherGrid({
    super.key,
    required this.vouchers,
    this.padding = EdgeInsets.zero,
  });

  final List<VoucherModel> vouchers;
  final EdgeInsetsGeometry padding;

  Future<void> _copyCode(BuildContext context, VoucherModel voucher) async {
    await Clipboard.setData(ClipboardData(text: voucher.code));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Copied ${voucher.code}')));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: VoucherCard.designSize.aspectRatio,
      // sits inside the home scroll view
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      children: [
        for (final voucher in vouchers)
          VoucherCard(
            voucher: voucher,
            onTap: () => _copyCode(context, voucher),
          ),
      ],
    );
  }
}
