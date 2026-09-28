import 'package:flutter/material.dart';
import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/data/repositories/category_repository.dart';
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

  // TODO: load the user's saved addresses
  final _savedAddresses = [
    '92 Hang Trong',
    '14 Ly Thuong Kiet',
    '7 Trang Tien',
  ];
  late String _deliveryAddress = _savedAddresses.first;

  final _categories = CategoryRepository().getCategories();
  final _searchInputController = TextEditingController();

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(
              deliveryAddress: _deliveryAddress,
              savedAddresses: _savedAddresses,
              onDeliveryAddressChanged: (address) =>
                  setState(() => _deliveryAddress = address),
              // TODO: push the add address screen
              onAddAddressTap: () {},
              // TODO: open the cart and the side menu
              onBagTap: () {},
              onMenuTap: () {},
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
              sliver: SliverList.list(
                children: [
                  HomeSearchField(controller: _searchInputController),
                  _sectionGap,
                  // the carousel already adds the gutter
                  const PromoCarousel(promos: homePromos, horizontalPadding: 0),
                  _sectionGap,
                  HomeCategories(categories: _categories),
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
