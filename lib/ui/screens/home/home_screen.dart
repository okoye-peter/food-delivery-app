import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/data/repositories/category_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/screens/home/widgets/home_app_bar.dart';
import 'package:yummy/ui/screens/home/widgets/home_categories.dart';
import 'package:yummy/ui/screens/home/widgets/home_nearby_products.dart';
import 'package:yummy/ui/screens/home/widgets/home_search_field.dart';
import 'package:yummy/ui/screens/home/widgets/home_top_discounts.dart';
import 'package:yummy/ui/screens/home/widgets/home_top_vouchers.dart';
import 'package:yummy/ui/screens/home/widgets/promo_carousel.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _sectionGap = SizedBox(height: 20);

  // TODO: load the user's selected address
  String _deliveryAddress = '92 Hang Trong';

  final _categories = CategoryRepository().getCategories();
  /// Opens the address screen; it can pop with the address to deliver to.
  Future<void> _openAddressScreen() async {
    final address = await context.push<String>(AppRoutes.address);
    if (address != null) setState(() => _deliveryAddress = address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(
              deliveryAddress: _deliveryAddress,
              onDeliveryAddressTap: _openAddressScreen,
              // TODO: open the side menu
              onMenuTap: () {},
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
              sliver: SliverList.list(
                children: [
                  const HomeSearchField(),
                  _sectionGap,
                  // the carousel already adds the gutter
                  const PromoCarousel(promos: homePromos, horizontalPadding: 0),
                  _sectionGap,
                  HomeCategories(
                    categories: _categories,
                    onCategoryTap: (category) => context.go(
                      AppRoutes.menuWith(categoryId: category.id),
                    ),
                  ),
                  _sectionGap,
                  const HomeTopDiscounts(products: promoProducts),
                  _sectionGap,
                  const HomeTopVouchers(vouchers: vouchers),
                  _sectionGap,
                  const HomeNearbyProducts(products: nearbyProducts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
