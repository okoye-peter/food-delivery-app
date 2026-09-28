import 'package:flutter/material.dart';
import 'package:yummy/data/models/voucher_model.dart';
import 'package:yummy/ui/screens/home/widgets/home_section_card.dart';
import 'package:yummy/ui/screens/home/widgets/voucher_grid.dart';

/// "Top voucher" card: title, voucher count and a grid of voucher cards.
class HomeTopVouchers extends StatelessWidget {
  const HomeTopVouchers({super.key, required this.vouchers});

  final List<VoucherModel> vouchers;

  @override
  Widget build(BuildContext context) {
    return HomeSectionCard(
      title: 'Top voucher',
      // TODO: use the real total from the API
      subtitle: 'We have 50 discount codes',
      trailing: const HomeSectionChevron(),
      child: VoucherGrid(
        vouchers: vouchers,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      ),
    );
  }
}
