import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/screens/orders/widgets/order_card.dart';

/// Orders tab: ongoing orders to track, and past ones to rate or reorder.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = OrderRepository.instance;
    final primary = Theme.of(context).colorScheme.primary;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PageAppBar(
          title: 'My orders',
          showBack: false,
          bottom: TabBar(
            indicatorColor: primary,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: context.colors.sectionTitle,
            unselectedLabelColor: context.colors.inputLabel,
            dividerColor: context.colors.divider,
            labelStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Ongoing'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: ListenableBuilder(
          listenable: orders,
          builder: (context, _) => TabBarView(
            children: [
              _OrderList(
                orders: orders.activeOrders,
                empty: EmptyState(
                  icon: Icons.delivery_dining,
                  title: 'No ongoing orders',
                  message: 'Orders you place will show up here so you can track them.',
                  actionLabel: 'Order now',
                  onAction: () => context.go(AppRoutes.menu),
                ),
              ),
              _OrderList(
                orders: orders.pastOrders,
                empty: const EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'No past orders',
                  message: 'Delivered orders will be listed here.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  const _OrderList({required this.orders, required this.empty});

  final List<OrderModel> orders;
  final Widget empty;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return empty;
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) => OrderCard(order: orders[index]),
    );
  }
}
