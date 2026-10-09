import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/data/models/product_filter.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/screens/address/address_screen.dart';
import 'package:yummy/ui/screens/cart/cart_screen.dart';
import 'package:yummy/ui/screens/catalog/catalog_screen.dart';
import 'package:yummy/ui/screens/checkout/checkout_screen.dart';
import 'package:yummy/ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:yummy/ui/screens/forgot_password/reset_password_screen.dart';
import 'package:yummy/ui/screens/forgot_password/verify_code_screen.dart';
import 'package:yummy/ui/screens/home/home_screen.dart';
import 'package:yummy/ui/screens/onboarding/onboarding_screen.dart';
import 'package:yummy/ui/screens/orders/order_detail_screen.dart';
import 'package:yummy/ui/screens/orders/orders_screen.dart';
import 'package:yummy/ui/screens/orders/rate_order_screen.dart';
import 'package:yummy/ui/screens/product/product_detail_screen.dart';
import 'package:yummy/ui/screens/saved/saved_screen.dart';
import 'package:yummy/ui/screens/search/search_screen.dart';
import 'package:yummy/ui/screens/shell/app_shell.dart';
import 'package:yummy/ui/screens/sign_in/sign_in_screen.dart';
import 'package:yummy/ui/screens/sign_up/sign_up_screen.dart';

// Routes given this key open full screen, over the bottom navigation bar
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyCode,
      builder: (context, state) =>
          VerifyCodeScreen(email: state.uri.queryParameters['email'] ?? ''),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => ResetPasswordScreen(
        email: state.uri.queryParameters['email'] ?? '',
        code: state.uri.queryParameters['code'] ?? '',
      ),
    ),

    // requires auth
    // the tabs keep their own stack and scroll position when switching
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              builder: (context, state) => HomeScreen(),
              routes: [
                // nested so home is always underneath and back returns to it
                GoRoute(
                  path: AppRoutes.addressSegment,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const AddressScreen(),
                ),
                GoRoute(
                  path: AppRoutes.searchSegment,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const SearchScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.menu,
              builder: (context, state) {
                final params = state.uri.queryParameters;
                return CatalogScreen(
                  // a new link (e.g. another category from home) starts
                  // with fresh filters
                  key: ValueKey(state.uri.query),
                  initialFilter: ProductFilter(
                    categoryId: params['category'],
                    query: params['q'] ?? '',
                    dealsOnly: params['deals'] == '1',
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.saved,
              builder: (context, state) => const SavedScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.orders,
              builder: (context, state) => const OrdersScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      OrderDetailScreen(orderId: state.pathParameters['id']!),
                  routes: [
                    GoRoute(
                      path: AppRoutes.rateSegment,
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) =>
                          RateOrderScreen(orderId: state.pathParameters['id']!),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '${AppRoutes.product}/:id',
      builder: (context, state) =>
          ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: AppRoutes.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
  ],
);
