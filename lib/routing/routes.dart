import 'package:go_router/go_router.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:yummy/ui/screens/forgot_password/reset_password_screen.dart';
import 'package:yummy/ui/screens/forgot_password/verify_code_screen.dart';
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
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyCode,
      builder: (context, state) => VerifyCodeScreen(
        email: state.uri.queryParameters['email'] ?? '',
      ),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => ResetPasswordScreen(
        email: state.uri.queryParameters['email'] ?? '',
        code: state.uri.queryParameters['code'] ?? '',
      ),
    ),
  ],
);