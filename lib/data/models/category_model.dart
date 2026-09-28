import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.gradient,
    required this.logo,
  });

  final String id;
  final String name;
  final LinearGradient gradient;
  final String logo;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      gradient: _parseGradient(json['gradient']),
      logo: json['logo'] as String,
    );
  }

  static const _fallback = LinearGradient(
    colors: [Color(0xFFEEEEEE), Color(0xFFDDDDDD)],
  );

  static LinearGradient _parseGradient(dynamic value) {
    if (value is! List || value.isEmpty) return _fallback;
    final colors = value.whereType<String>().map(_hexToColor).toList();
    if (colors.isEmpty) return _fallback;
    if (colors.length == 1) colors.add(colors.first); // gradient needs 2+
    return LinearGradient(
      // [light, dark]: light at the top-right fading to dark at the bottom-left
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: colors,
    );
  }

  static Color _hexToColor(String hex) {
    var h = hex.replaceFirst('#', '');
    if (h.length == 6) h = 'FF$h'; // add full opacity
    return Color(int.tryParse(h, radix: 16) ?? 0xFFEEEEEE);
  }
}
