import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/curved_bottom_clipper.dart';
import 'package:yummy/ui/core/widgets/labeled_text_field.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class SignUpScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const _maxContentWidth = 480.0;
  static final _emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

  final _nameInputController = TextEditingController();
  final _phoneInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  bool _isPasswordObscure = true;

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  bool isValidPhoneNumber(String value) {
    try {
      final phone = PhoneNumber.parse(value, callerCountry: IsoCode.NG);

      return phone.isValid();
    } catch (_) {
      return false;
    }
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
                                  top: topPadding + 43,
                                  left: 15,
                                  child: SizedBox(
                                    width: contentWidth * 0.6,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Create Account',
                                          style: GoogleFonts.lato(
                                            color: context.colors.title,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        Text(
                                          'Sign up and experience the service',
                                          softWrap: true,
                                          style: GoogleFonts.lato(
                                            color: context.colors.subtitle,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: topPadding + 22,
                                  right: -65,
                                  child: Image.asset(
                                    'assets/images/authentication/sign up food.png',
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
                                label: 'Full Name',
                                hintText: 'Enter your full name',
                                controller: _nameInputController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'full anme is required';

                                  if (!_emailRegex.hasMatch(value.trim()))
                                    return 'Invalid full anme';

                                  return null;
                                },
                              ),
                              const SizedBox(height: 35),
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
                                label: 'Phone no.',
                                hintText: 'Enter your phone number',
                                controller: _phoneInputController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Phone number is required';
                                  }

                                  if (!isValidPhoneNumber(value.trim())) {
                                    return 'Enter a valid phone number';
                                  }

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

                              isTallScreen
                                  ? const SizedBox(height: 40)
                                  : const Spacer(),
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
                                    'Create Account',
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
                                      'Already have an account?',
                                      style: GoogleFonts.inter(
                                        color: context.colors.mutedText,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 6),

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
                                          context.push(AppRoutes.signIn),
                                      child: Text(
                                        'Sign in',
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
