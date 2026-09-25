import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.headerBlue,
    required this.headerYellow,
    required this.title,
    required this.subtitle,
    required this.inputLabel,
    required this.inputHint,
    required this.inputBorder,
    required this.inputText,
    required this.bodyText,
    required this.link,
    required this.mutedText,
    required this.facebookButton,
    required this.appleButton,
    required this.onAppleButton,
  });

  final Color headerBlue;
  final Color headerYellow;
  final Color title;
  final Color subtitle;
  final Color inputLabel;
  final Color inputHint;
  final Color inputBorder;
  final Color inputText;
  final Color bodyText;
  final Color link;
  final Color mutedText;
  final Color facebookButton;
  final Color appleButton;
  final Color onAppleButton;

  static const light = AppColors(
    headerBlue: Color(0x4D7ABEEB),
    headerYellow: Color(0x66FED075),
    title: Color(0xFF313337),
    subtitle: Color(0xFF70747C),
    inputLabel: Color(0xFFA4A7AD),
    inputHint: Color(0xFF585D63),
    inputBorder: Color(0xFFEFF0F3),
    inputText: Color(0xFF313337),
    bodyText: Color(0xFFA4A7AD),
    link: Color(0xFF3A72D6),
    mutedText: Color(0xFF8F8F8F),
    facebookButton: Color(0xFF3A72D6),
    appleButton: Color(0xFF313337),
    onAppleButton: Colors.white,
  );

  static const dark = AppColors(
    headerBlue: Color(
      0x337ABEEB,
    ), // lower opacity: bright tints glare on dark backgrounds
    headerYellow: Color(0x40FED075),
    title: Color(0xFFF2F3F5),
    subtitle: Color(0xFFB4B8BF), // stays readable over the blue header tint
    inputLabel: Color(0xFF70747C),
    inputHint: Color(0xFFD7D7D8),
    inputBorder: Color(0xFF45484E),
    inputText: Color(0xFFF9FAFB),
    bodyText: Color(0xFFA4A7AD),
    link: Color(
      0xFF6B9BEB,
    ), // lighter blue: #3A72D6 is too dim on the dark page
    mutedText: Color(0xFF8F8F8F),
    facebookButton: Color(0xFF3A72D6),
    // Apple's guideline: white button on dark backgrounds
    appleButton: Colors.white,
    onAppleButton: Colors.black,
  );

  @override
  AppColors copyWith({
    Color? headerBlue,
    Color? headerYellow,
    Color? title,
    Color? subtitle,
    Color? inputLabel,
    Color? inputHint,
    Color? inputBorder,
    Color? inputText,
    Color? bodyText,
    Color? link,
    Color? mutedText,
    Color? facebookButton,
    Color? appleButton,
    Color? onAppleButton,
  }) => AppColors(
    headerBlue: headerBlue ?? this.headerBlue,
    headerYellow: headerYellow ?? this.headerYellow,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    inputLabel: inputLabel ?? this.inputLabel,
    inputHint: inputHint ?? this.inputHint,
    inputBorder: inputBorder ?? this.inputBorder,
    inputText: inputText ?? this.inputText,
    bodyText: bodyText ?? this.bodyText,
    link: link ?? this.link,
    mutedText: mutedText ?? this.mutedText,
    facebookButton: facebookButton ?? this.facebookButton,
    appleButton: appleButton ?? this.appleButton,
    onAppleButton: onAppleButton ?? this.onAppleButton,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      headerBlue: Color.lerp(headerBlue, other.headerBlue, t)!,
      headerYellow: Color.lerp(headerYellow, other.headerYellow, t)!,
      title: Color.lerp(title, other.title, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
      inputLabel: Color.lerp(inputLabel, other.inputLabel, t)!,
      inputHint: Color.lerp(inputHint, other.inputHint, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputText: Color.lerp(inputText, other.inputText, t)!,
      bodyText: Color.lerp(bodyText, other.bodyText, t)!,
      link: Color.lerp(link, other.link, t)!,
      mutedText: Color.lerp(mutedText, other.mutedText, t)!,
      facebookButton: Color.lerp(facebookButton, other.facebookButton, t)!,
      appleButton: Color.lerp(appleButton, other.appleButton, t)!,
      onAppleButton: Color.lerp(onAppleButton, other.onAppleButton, t)!,
    );
  }
}

// Shortcut so screens can write context.colors.title
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
