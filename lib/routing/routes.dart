import 'package:go_router/go_router.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/screens/onboarding/onboarding_screen.dart';
import 'package:yummy/ui/screens/sign_in/sign_in_screen.dart';
import 'package:yummy/ui/screens/sign_up/sign_up_screen.dart';

final routes = GoRouter(
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
  ],
);