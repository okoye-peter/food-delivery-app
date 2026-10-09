import 'package:flutter/material.dart';
import 'package:yummy/data/models/cart_item_model.dart';
import 'package:yummy/data/models/category_model.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/data/models/voucher_model.dart';

// TODO: replace with data from the API
const _images = 'assets/images/dummy/food_images';

const _categoryLogos = 'assets/images/dashboard/categories';

// TODO: replace the placeholder logos (dummy food photos) with real icons
const riceCategory = CategoryModel(
  id: '1',
  name: 'Rice',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFFFC2A8), Color(0xFFFF9A76)],
  ),
  logo: '$_images/jollof_rice.png',
);

const fastFoodCategory = CategoryModel(
  id: '2',
  name: 'Fast Food',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFFFE08A), Color(0xFFFFC94A)],
  ),
  logo: '$_images/burger_3d.png',
);

const drinkCategory = CategoryModel(
  id: '3',
  name: 'Drinks',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFA8D8F5), Color(0xFF7BBFEA)],
  ),
  logo: '$_images/chocolate_frappuccino.png',
);

const breadCategory = CategoryModel(
  id: '4',
  name: 'Bread',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFD8C2F5), Color(0xFFBC9BEC)],
  ),
  logo: '$_images/donut_3d.png',
);

const soupCategory = CategoryModel(
  id: '6',
  name: 'Soup',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFF7D38A), Color(0xFFF0B94A)],
  ),
  logo: '$_images/egusi_soup.png',
);

const localCategory = CategoryModel(
  id: '7',
  name: 'Local',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFB6E3A1), Color(0xFF8FCF74)],
  ),
  logo: '$_images/moi_moi.png',
);

const saladCategory = CategoryModel(
  id: '8',
  name: 'Salad',
  // light at the top-right fading to dark at the bottom-left
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFF5B8D8), Color(0xFFEC93C2)],
  ),
  logo: '$_images/fruit_salad.png',
);

const foodCategories = [
  riceCategory,
  fastFoodCategory,
  drinkCategory,
  breadCategory,
  soupCategory,
  localCategory,
  saladCategory,
];

/// Discounted products for the "Top discounts" section.
const promoProducts = [
  ProductModel(
    id: 'promo-1',
    name: 'Chicken Fried Rice',
    image: '$_images/fried_rice_chicken.png',
    category: riceCategory,
    price: 8.40,
    originalPrice: 12.00,
    rating: 4.8,
    ratingCount: 1240,
  ),
  ProductModel(
    id: 'promo-2',
    name: 'Classic Cheeseburger',
    image: '$_images/cheeseburger.png',
    category: fastFoodCategory,
    price: 6.50,
    originalPrice: 9.00,
    rating: 4.6,
    ratingCount: 986,
  ),
  ProductModel(
    id: 'promo-3',
    name: 'Crispy Fried Chicken',
    image: '$_images/fried_chicken.png',
    category: fastFoodCategory,
    price: 7.20,
    originalPrice: 9.60,
    rating: 4.7,
    ratingCount: 1532,
  ),
  ProductModel(
    id: 'promo-4',
    name: 'Party Jollof Rice',
    image: '$_images/jollof_rice.png',
    category: riceCategory,
    price: 7.00,
    originalPrice: 10.00,
    rating: 4.9,
    ratingCount: 2105,
  ),
  ProductModel(
    id: 'promo-5',
    name: 'Chocolate Frappuccino',
    image: '$_images/chocolate_frappuccino.png',
    category: drinkCategory,
    price: 3.60,
    originalPrice: 4.50,
    rating: 4.5,
    ratingCount: 642,
  ),
  ProductModel(
    id: 'promo-6',
    name: 'Sugar Donuts (6 pcs)',
    image: '$_images/sugar_donuts.png',
    category: breadCategory,
    price: 3.00,
    originalPrice: 5.00,
    rating: 4.4,
    ratingCount: 418,
  ),
  ProductModel(
    id: 'promo-7',
    name: 'Fresh Fruit Salad',
    image: '$_images/fruit_salad.png',
    category: saladCategory,
    price: 4.25,
    originalPrice: 5.00,
    rating: 4.6,
    ratingCount: 377,
  ),
];

/// Full-price catalogue, one product per image.
const products = [
  ProductModel(
    id: 'product-1',
    name: 'Baked Snapper',
    image: '$_images/baked_snapper.png',
    category: localCategory,
    price: 14.50,
    rating: 4.7,
    ratingCount: 312,
  ),
  ProductModel(
    id: 'product-2',
    name: 'Double Beef Burger',
    image: '$_images/burger_3d.png',
    category: fastFoodCategory,
    price: 9.99,
    rating: 4.6,
    ratingCount: 874,
  ),
  ProductModel(
    id: 'product-3',
    name: 'Classic Cheeseburger',
    image: '$_images/cheeseburger.png',
    category: fastFoodCategory,
    price: 9.00,
    rating: 4.6,
    ratingCount: 986,
  ),
  ProductModel(
    id: 'product-4',
    name: 'Chocolate Frappuccino',
    image: '$_images/chocolate_frappuccino.png',
    category: drinkCategory,
    price: 4.50,
    rating: 4.5,
    ratingCount: 642,
  ),
  ProductModel(
    id: 'product-5',
    name: 'Frosted Cupcakes (4 pcs)',
    image: '$_images/cupcakes.png',
    category: breadCategory,
    price: 6.00,
    rating: 4.3,
    ratingCount: 205,
  ),
  ProductModel(
    id: 'product-6',
    name: 'Glazed Donut',
    image: '$_images/donut_3d.png',
    category: breadCategory,
    price: 1.80,
    rating: 4.2,
    ratingCount: 530,
  ),
  ProductModel(
    id: 'product-7',
    name: 'Egusi Soup',
    image: '$_images/egusi_soup.png',
    category: soupCategory,
    price: 11.00,
    rating: 4.8,
    ratingCount: 1103,
  ),
  ProductModel(
    id: 'product-8',
    name: 'French Fries',
    image: '$_images/french_fries.png',
    category: fastFoodCategory,
    price: 3.50,
    rating: 4.4,
    ratingCount: 1420,
  ),
  ProductModel(
    id: 'product-9',
    name: 'Crispy Fried Chicken',
    image: '$_images/fried_chicken.png',
    category: fastFoodCategory,
    price: 9.60,
    rating: 4.7,
    ratingCount: 1532,
  ),
  ProductModel(
    id: 'product-10',
    name: 'Chicken Fried Rice',
    image: '$_images/fried_rice_chicken.png',
    category: riceCategory,
    price: 12.00,
    rating: 4.8,
    ratingCount: 1240,
  ),
  ProductModel(
    id: 'product-11',
    name: 'Fresh Fruit Salad',
    image: '$_images/fruit_salad.png',
    category: saladCategory,
    price: 5.00,
    rating: 4.6,
    ratingCount: 377,
  ),
  ProductModel(
    id: 'product-12',
    name: 'Party Jollof Rice',
    image: '$_images/jollof_rice.png',
    category: riceCategory,
    price: 10.00,
    rating: 4.9,
    ratingCount: 2105,
  ),
  ProductModel(
    id: 'product-13',
    name: 'Moi Moi',
    image: '$_images/moi_moi.png',
    category: localCategory,
    price: 4.00,
    rating: 4.5,
    ratingCount: 689,
  ),
  ProductModel(
    id: 'product-14',
    name: 'Beef Noodle Bowl',
    image: '$_images/noodle_bowl_3d.png',
    category: fastFoodCategory,
    price: 8.75,
    rating: 4.6,
    ratingCount: 751,
  ),
  ProductModel(
    id: 'product-15',
    name: 'Okra Soup',
    image: '$_images/okra_soup.png',
    category: soupCategory,
    price: 10.50,
    rating: 4.7,
    ratingCount: 864,
  ),
  ProductModel(
    id: 'product-16',
    name: 'Puff Puff (10 pcs)',
    image: '$_images/puff_puff.png',
    category: breadCategory,
    price: 2.50,
    rating: 4.5,
    ratingCount: 998,
  ),
  ProductModel(
    id: 'product-17',
    name: 'Sugar Donuts (6 pcs)',
    image: '$_images/sugar_donuts.png',
    category: breadCategory,
    price: 5.00,
    rating: 4.4,
    ratingCount: 418,
  ),
];

/// Products near the user, with an ingredients line and a distance.
const nearbyProducts = [
  ProductModel(
    id: 'nearby-1',
    name: 'Combination fried rice',
    image: '$_images/burger_3d.png',
    category: riceCategory,
    price: 9.50,
    rating: 4.5,
    ratingCount: 128,
    description: 'Shrimp, ham, mix vegetable',
    distanceKm: 1.2,
  ),
  ProductModel(
    id: 'nearby-2',
    name: 'Party Jollof Rice',
    image: '$_images/jollof_rice.png',
    category: riceCategory,
    price: 10.00,
    rating: 4.9,
    ratingCount: 2105,
    description: 'Smoky tomato rice, fried plantain, chicken',
    distanceKm: 0.8,
  ),
  ProductModel(
    id: 'nearby-3',
    name: 'Egusi Soup',
    image: '$_images/egusi_soup.png',
    category: soupCategory,
    price: 11.00,
    rating: 4.8,
    ratingCount: 1103,
    description: 'Melon seed, spinach, assorted meat',
    distanceKm: 2.4,
  ),
  ProductModel(
    id: 'nearby-4',
    name: 'Crispy Fried Chicken',
    image: '$_images/fried_chicken.png',
    category: fastFoodCategory,
    price: 9.60,
    rating: 4.7,
    ratingCount: 1532,
    description: 'Spiced chicken, coleslaw, ketchup',
    distanceKm: 3.1,
  ),
];

const vouchers = [
  VoucherModel(
    id: 'voucher-1',
    discount: '20%',
    code: 'THANTHAN',
    remaining: 40,
  ),
  VoucherModel(
    id: 'voucher-2',
    discount: '15%',
    code: 'YUMMYCODE',
    remaining: 20,
  ),
  VoucherModel(
    id: 'voucher-3',
    discount: '\$10',
    code: 'LUVYUMMY',
    remaining: 40,
  ),
  VoucherModel(
    id: 'voucher-4',
    discount: '50%',
    code: 'THANTHAN',
    remaining: 0,
  ),
];

/// Every meal the menu shows: the full-price catalogue, with the promo
/// version swapped in for meals that are on discount.
final catalogProducts = [
  for (final product in products)
    promoProducts.where((p) => p.name == product.name).firstOrNull ?? product,
];

/// One order on its way and two delivered ones (one rated, one not), dated
/// relative to [now] so they always look recent.
List<OrderModel> buildDummyOrders(DateTime now) {
  final onTheWayPlaced = now.subtract(const Duration(minutes: 18));
  final yesterday = now.subtract(const Duration(days: 1, hours: 2));
  final lastWeek = now.subtract(const Duration(days: 5, hours: 4));

  return [
    OrderModel(
      id: 'YM1048',
      items: [
        CartItemModel(product: promoProducts[3], quantity: 2),
        CartItemModel(product: promoProducts[4], quantity: 1),
      ],
      deliveryAddress: '92 Hang Trong',
      paymentMethod: PaymentMethod.card,
      placedAt: onTheWayPlaced,
      status: OrderStatus.onTheWay,
      statusTimes: {
        OrderStatus.placed: onTheWayPlaced,
        OrderStatus.preparing: onTheWayPlaced.add(const Duration(minutes: 3)),
        OrderStatus.onTheWay: onTheWayPlaced.add(const Duration(minutes: 14)),
      },
      deliveryFee: 2,
      riderName: 'Tunde Bakare',
      riderPhone: '+234 801 234 5678',
    ),
    OrderModel(
      id: 'YM1043',
      items: [
        CartItemModel(product: promoProducts[1], quantity: 2),
        CartItemModel(product: products[7], quantity: 2),
        CartItemModel(product: promoProducts[2], quantity: 1),
      ],
      deliveryAddress: 'Floral JSC',
      paymentMethod: PaymentMethod.cash,
      placedAt: yesterday,
      status: OrderStatus.delivered,
      statusTimes: {
        OrderStatus.placed: yesterday,
        OrderStatus.preparing: yesterday.add(const Duration(minutes: 2)),
        OrderStatus.onTheWay: yesterday.add(const Duration(minutes: 15)),
        OrderStatus.delivered: yesterday.add(const Duration(minutes: 31)),
      },
      deliveryFee: 2,
      discount: 5,
      voucherCode: 'YUMMYCODE',
      riderName: 'Chidi Okafor',
    ),
    OrderModel(
      id: 'YM1037',
      items: [
        CartItemModel(product: nearbyProducts[2], quantity: 1),
        CartItemModel(product: products[15], quantity: 2),
      ],
      deliveryAddress: '92 Hang Trong',
      paymentMethod: PaymentMethod.wallet,
      placedAt: lastWeek,
      status: OrderStatus.delivered,
      statusTimes: {
        OrderStatus.placed: lastWeek,
        OrderStatus.preparing: lastWeek.add(const Duration(minutes: 4)),
        OrderStatus.onTheWay: lastWeek.add(const Duration(minutes: 20)),
        OrderStatus.delivered: lastWeek.add(const Duration(minutes: 38)),
      },
      deliveryFee: 2,
      riderName: 'Tunde Bakare',
      rating: const OrderRating(
        stars: 5,
        tags: ['Tasty', 'Hot & fresh'],
        comment: 'Best egusi in town, will order again.',
      ),
    ),
  ];
}
