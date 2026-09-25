import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/curved_bottom_clipper.dart';
import 'package:yummy/ui/core/widgets/labeled_text_field.dart';

class SignInScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const _maxContentWidth = 480.0;
  static final _emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  bool _isPasswordObscure = true;
  bool _isRememberMeCheck = false;

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final screenHeight = MediaQuery.heightOf(context);
    final screenWidth = MediaQuery.widthOf(context);

    // Header scales with the screen but always leaves room for the title
    // (short landscape screens) and stops growing on tall tablets.
    final headerHeight = math.max(
      topPadding + 140,
      math.min(screenHeight * 0.27, 300.0),
    );
    final contentWidth = math.min(screenWidth, _maxContentWidth);
    final imageWidth = math.min(
      (contentWidth * 0.5).clamp(140.0, 260.0),
      headerHeight,
    );
    // On tall screens keep the buttons grouped with the form instead of
    // pushing them to the bottom edge.
    final isTallScreen = screenHeight > 900;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: const CurvedBottomClipper(curveDepth: 25),
                      child: Container(
                        width: double.infinity,
                        height: headerHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              context.colors.headerBlue,
                              context.colors.headerYellow,
                            ],
                            stops: [0.05, 0.75],
                          ),
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: _maxContentWidth,
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: topPadding + 45,
                                  left: 15,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sign in',
                                        style: GoogleFonts.lato(
                                          color: context.colors.title,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      Text(
                                        'Welcome to yummy!',
                                        style: GoogleFonts.lato(
                                          color: context.colors.subtitle,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Positioned(
                                  top: topPadding + 15,
                                  right: -28,
                                  child: Image.asset(
                                    'assets/images/authentication/sign in food.png',
                                    width: imageWidth,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _maxContentWidth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          15,
                          0,
                          15,
                          bottomPadding + 20,
                        ),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabeledTextField(
                                label: 'Email Address',
                                hintText: 'Enter your email address',
                                controller: _emailInputController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'Email is required';

                                  if (!_emailRegex.hasMatch(value.trim()))
                                    return 'Invalid Email';

                                  return null;
                                },
                              ),
                              const SizedBox(height: 35),
                              LabeledTextField(
                                label: 'Password',
                                hintText: 'Enter your password',
                                controller: _passwordInputController,
                                textInputAction: TextInputAction.done,
                                obscureText: _isPasswordObscure,
                                enableSuggestions: false,
                                suffixIcon: IconButton(
                                  onPressed: () => setState(
                                    () => _isPasswordObscure =
                                        !_isPasswordObscure,
                                  ),
                                  icon: Icon(
                                    _isPasswordObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: context.colors.inputText,
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'Password is required';

                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(
                                        () => _isRememberMeCheck =
                                            !_isRememberMeCheck,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: _isRememberMeCheck,
                                            onChanged: (bool? value) =>
                                                setState(
                                                  () => _isRememberMeCheck =
                                                      value ?? false,
                                                ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: const VisualDensity(
                                              horizontal: -4,
                                              vertical: -4,
                                            ),
                                            side: BorderSide(
                                              color: context.colors.bodyText,
                                              width: 2,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Remember me',
                                            style: GoogleFonts.inter(
                                              color: context.colors.bodyText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: () => context.push(
                                        AppRoutes.forgotPassword,
                                      ),
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.inter(
                                          color: context.colors.link,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              isTallScreen
                                  ? const SizedBox(height: 40)
                                  : const Spacer(),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        backgroundColor:
                                            context.colors.facebookButton,
                                        minimumSize: const Size(
                                          double.infinity,
                                          60,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      label: Text(
                                        'Facebook',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.facebook,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        backgroundColor:
                                            context.colors.appleButton,
                                        minimumSize: const Size(
                                          double.infinity,
                                          60,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      label: Text(
                                        'Apple',
                                        style: GoogleFonts.inter(
                                          color: context.colors.onAppleButton,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.apple,
                                        color: context.colors.onAppleButton,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                    minimumSize: const Size(
                                      double.infinity,
                                      60,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Sign in',
                                    style: GoogleFonts.inter(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight(650),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Do not have an account?',
                                      style: GoogleFonts.inter(
                                        color: context.colors.mutedText,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    /**
                                   * TODO: add the route
                                   */
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                        ),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () =>
                                          context.push(AppRoutes.signUp),
                                      child: Text(
                                        'Sign up',
                                        style: GoogleFonts.inter(
                                          color: context.colors.link,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
