import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/auth_scaffold.dart';
import 'package:yummy/ui/core/widgets/labeled_text_field.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  static const _minPasswordLength = 8;

  final _formKey = GlobalKey<FormState>();
  final _passwordInputController = TextEditingController();
  final _confirmPasswordInputController = TextEditingController();
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _passwordInputController.dispose();
    _confirmPasswordInputController.dispose();
    super.dispose();
  }

  Widget _visibilityToggle(bool isObscure, VoidCallback onPressed) =>
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: context.colors.inputText,
        ),
      );

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    // TODO: call the reset password API with widget.email, widget.code
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const _PasswordChangedDialog(),
    );
    if (mounted) context.go(AppRoutes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'New Password',
      subtitle: 'Create a new password for your account',
      body: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledTextField(
                label: 'New Password',
                hintText: 'Enter your new password',
                controller: _passwordInputController,
                textInputAction: TextInputAction.next,
                obscureText: _isPasswordObscure,
                enableSuggestions: false,
                suffixIcon: _visibilityToggle(
                  _isPasswordObscure,
                  () => setState(
                    () => _isPasswordObscure = !_isPasswordObscure,
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty)
                    return 'Password is required';

                  if (value.length < _minPasswordLength)
                    return 'Password must be at least $_minPasswordLength characters';

                  return null;
                },
              ),
              const SizedBox(height: 35),
              LabeledTextField(
                label: 'Confirm Password',
                hintText: 'Re-enter your new password',
                controller: _confirmPasswordInputController,
                textInputAction: TextInputAction.done,
                obscureText: _isConfirmPasswordObscure,
                enableSuggestions: false,
                suffixIcon: _visibilityToggle(
                  _isConfirmPasswordObscure,
                  () => setState(
                    () => _isConfirmPasswordObscure =
                        !_isConfirmPasswordObscure,
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty)
                    return 'Please confirm your password';

                  if (value != _passwordInputController.text)
                    return 'Passwords do not match';

                  return null;
                },
              ),
            ],
          ),
        ),
      ],
      footer: [PrimaryButton(label: 'Reset Password', onPressed: _resetPassword)],
    );
  }
}

class _PasswordChangedDialog extends StatelessWidget {
  const _PasswordChangedDialog();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, color: primary, size: 44),
            ),
            const SizedBox(height: 20),
            Text(
              'Password Changed',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: context.colors.title,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your password has been reset. You can now sign in with your new password.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: context.colors.subtitle,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Back to Sign in',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
