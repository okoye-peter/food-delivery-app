import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    bool isPasswordObscure = true;
    bool isRememberMeCheck = false;

    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final screenHeight = MediaQuery.heightOf(context);
    final screenWidth = MediaQuery.widthOf(context);

    final emailInputController = TextEditingController();
    final passwordInputController = TextEditingController();
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

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
                      clipper: const _CurvedBottomClipper(curveDepth: 25),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.27,
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
                        child: Stack(
                          children: [
                            Positioned(
                              top: topPadding + 45,
                              left: 15,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: 210,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, bottomPadding + 20),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA4A7AD),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: emailInputController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFEFF0F3),
                                ),
                              ),
                              hint: Text(
                                'Enter your email address',
                                style: GoogleFonts.inter(
                                  color: Color(0xFF585D63),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty)
                                return 'Email is required';

                              if (!emailRegex.hasMatch(value.trim()))
                                return 'Invalid Email';

                              return null;
                            },
                          ),
                          const SizedBox(height: 35),
                          Text(
                            'Password',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA4A7AD),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: passwordInputController,
                            textInputAction: TextInputAction.done,
                            obscureText: isPasswordObscure,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () => isPasswordObscure = !isPasswordObscure,
                                ),
                                icon: Icon(
                                  isPasswordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Color(0xFF313337),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFEFF0F3),
                                ),
                              ),
                              hint: Text(
                                'Enter your password',
                                style: GoogleFonts.inter(
                                  color: Color(0xFF585D63),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty)
                                return 'Password is required';

                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => setState(
                                  () => isRememberMeCheck = !isRememberMeCheck,
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: isRememberMeCheck,
                                      onChanged: (bool? value) => setState(
                                        () =>
                                            isRememberMeCheck = value ?? false,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal: -4,
                                        vertical: -4,
                                      ),
                                      side: BorderSide(
                                        color: Color(0xFFA4A7AD),
                                        width: 2,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Remember me',
                                      style: GoogleFonts.inter(
                                        color: Color(0xFFA4A7AD),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /**
                         * TODO fix the forgot password
                         */
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF3A72D6),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    alignment: Alignment.center,
                                    backgroundColor: Color(0xFF3A72D6),
                                    minimumSize: const Size(
                                      double.infinity,
                                      60,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                                    backgroundColor: Color(0xFF313337),
                                    minimumSize: const Size(
                                      double.infinity,
                                      60,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  label: Text(
                                    'Apple',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.apple,
                                    color: Colors.white,
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
                                backgroundColor: Color(0xFFFEA159),
                                minimumSize: const Size(double.infinity, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Sign in',
                                style: GoogleFonts.inter(
                                  color: Color(0xFF313337),
                                  fontWeight: FontWeight(650),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Do not have an account?',
                                style: GoogleFonts.inter(
                                  color: Color(0xFF8F8F8F),
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
                                onPressed: () => context.push(AppRoutes.signUp),
                                child: Text(
                                  'Sign up',
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF3A72D6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

class _CurvedBottomClipper extends CustomClipper<Path> {
  const _CurvedBottomClipper({required this.curveDepth});

  final double curveDepth;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final top = h - curveDepth;
    // Control points pulled in from the edges so the curve leaves the sides
    // at an angle (no bend) while staying flat through the middle.
    final controlY = h + curveDepth / 3;

    return Path()
      ..lineTo(0, top)
      ..cubicTo(w * 0.2, controlY, w * 0.8, controlY, w, top)
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldReclip(_CurvedBottomClipper oldClipper) =>
      oldClipper.curveDepth != curveDepth;
}
