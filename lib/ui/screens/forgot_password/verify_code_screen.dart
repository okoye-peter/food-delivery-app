import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/auth_scaffold.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/ui/screens/forgot_password/widgets/otp_input.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  static const _codeLength = 4;
  static const _resendDelay = 60;

  final _codeInputController = TextEditingController();
  Timer? _resendTimer;
  int _secondsLeft = _resendDelay;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _codeInputController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _secondsLeft = _resendDelay);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) timer.cancel();
      setState(() => _secondsLeft--);
    });
  }

  void _resendCode() {
    // TODO: call the resend reset code API
    _codeInputController.clear();
    setState(() => _errorText = null);
    _startResendTimer();
  }

  void _verify() {
    if (_codeInputController.text.length < _codeLength) {
      setState(() => _errorText = 'Enter the $_codeLength-digit code');
      return;
    }

    // TODO: call the verify reset code API and pass its token on
    setState(() => _errorText = null);
    context.push(
      Uri(
        path: AppRoutes.resetPassword,
        queryParameters: {
          'email': widget.email,
          'code': _codeInputController.text,
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Verify Code',
      subtitle: 'Enter the $_codeLength-digit code we sent to your email',
      body: [
        Text.rich(
          TextSpan(
            text: 'Code sent to ',
            children: [
              TextSpan(
                text: widget.email,
                style: TextStyle(color: context.colors.inputText),
              ),
            ],
          ),
          style: GoogleFonts.inter(
            color: context.colors.bodyText,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        OtpInput(
          controller: _codeInputController,
          length: _codeLength,
          hasError: _errorText != null,
          onCompleted: (_) {
            if (_errorText != null) setState(() => _errorText = null);
          },
        ),
        if (_errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            _errorText!,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.error,
              fontSize: 13,
            ),
          ),
        ],
        const SizedBox(height: 25),
        Center(
          child: _secondsLeft > 0
              ? Text(
                  'Resend code in 0:${_secondsLeft.toString().padLeft(2, '0')}',
                  style: GoogleFonts.inter(
                    color: context.colors.mutedText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Didn't get the code?",
                      style: GoogleFonts.inter(
                        color: context.colors.mutedText,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 6),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: _resendCode,
                      child: Text(
                        'Resend',
                        style: GoogleFonts.inter(
                          color: context.colors.link,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
      footer: [PrimaryButton(label: 'Verify', onPressed: _verify)],
    );
  }
}
