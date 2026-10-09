class AppRoutes {
  AppRoutes._();

  static String home = '/';
  static String signIn = '/login';
  static String signUp = '/register';
  static String forgotPassword = '/forgot-password';
  static String verifyCode = '/forgot-password/verify';
  static String resetPassword = '/forgot-password/reset';
  static String dashboard = '/dashboard';

  // children of dashboard: only reachable on top of the home screen
  static String addressSegment = 'address';
  static String searchSegment = 'search';
  static String address = '$dashboard/$addressSegment';
  static String search = '$dashboard/$searchSegment';

  // bottom navigation tabs (dashboard is the first)
  static String menu = '/menu';
  static String saved = '/saved';
  static String orders = '/orders';

  // full screen, on top of the tabs
  static String cart = '/cart';
  static String checkout = '/checkout';
  static String product = '/product';
  static String rateSegment = 'rate';

  static String productDetail(String id) => '$product/$id';
  static String orderDetail(String id) => '$orders/$id';
  static String rateOrder(String id) => '$orders/$id/$rateSegment';

  /// Menu opened on a category, a search query and/or deals only.
  static String menuWith({
    String? categoryId,
    String? query,
    bool deals = false,
  }) {
    final params = {
      'category': ?categoryId,
      if (query != null && query.trim().isNotEmpty) 'q': query.trim(),
      if (deals) 'deals': '1',
    };
    // an empty map would leave a trailing "?"
    return Uri(
      path: menu,
      queryParameters: params.isEmpty ? null : params,
    ).toString();
  }
}
