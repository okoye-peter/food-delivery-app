import 'package:flutter/material.dart';

class OnboardingPill extends StatelessWidget {
  const OnboardingPill({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(9),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(999)),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
