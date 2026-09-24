import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.headerBlue,
    required this.headerYellow,
    required this.title,
    required this.subtitle,
  });

  final Color headerBlue;
  final Color headerYellow;
  final Color title;
  final Color subtitle;

  static const light = AppColors(
    headerBlue: Color(0x4D7ABEEB),
    headerYellow: Color(0x66FED075),
    title: Color(0xFF313337),
    subtitle: Color(0xFF70747C),
  );

  static const dark = AppColors(
    headerBlue: Color(0x337ABEEB),   // lower opacity: bright tints glare on dark backgrounds
    headerYellow: Color(0x40FED075),
    title: Color(0xFFF2F3F5),
    subtitle: Color(0xFFB4B8BF), // stays readable over the blue header tint
  );

  @override
  AppColors copyWith({Color? headerBlue, Color? headerYellow, Color? title, Color? subtitle}) =>
      AppColors(
        headerBlue: headerBlue ?? this.headerBlue,
        headerYellow: headerYellow ?? this.headerYellow,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
      );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      headerBlue: Color.lerp(headerBlue, other.headerBlue, t)!,
      headerYellow: Color.lerp(headerYellow, other.headerYellow, t)!,
      title: Color.lerp(title, other.title, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
    );
  }
}

// Shortcut so screens can write context.colors.title
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
