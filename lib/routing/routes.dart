import 'package:go_router/go_router.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/screens/onboarding_screen.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => OnboardingScreen(),
    ),
  ],
);