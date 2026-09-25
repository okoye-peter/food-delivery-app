import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/auth_scaffold.dart';
import 'package:yummy/ui/core/widgets/labeled_text_field.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static final _emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

  final _formKey = GlobalKey<FormState>();
  final _emailInputController = TextEditingController();

  @override
  void dispose() {
    _emailInputController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: call the send reset code API
    context.push(
      Uri(
        path: AppRoutes.verifyCode,
        queryParameters: {'email': _emailInputController.text.trim()},
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Forgot Password',
      subtitle: "Enter your email and we'll send you a code",
      body: [
        Form(
          key: _formKey,
          child: LabeledTextField(
            label: 'Email Address',
            hintText: 'Enter your email address',
            controller: _emailInputController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty)
                return 'Email is required';

              if (!_emailRegex.hasMatch(value.trim())) return 'Invalid Email';

              return null;
            },
          ),
        ),
      ],
      footer: [
        PrimaryButton(label: 'Send Code', onPressed: _sendCode),
        const SizedBox(height: 15),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Remember your password?',
                style: GoogleFonts.inter(
                  color: context.colors.mutedText,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 6),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRoutes.signIn),
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
    );
  }
}
