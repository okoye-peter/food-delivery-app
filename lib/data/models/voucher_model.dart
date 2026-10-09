class VoucherModel {
  const VoucherModel({
    required this.id,
    required this.discount,
    required this.code,
    required this.remaining,
  });

  final String id;

  /// Display value, e.g. "20%" or "$10".
  final String discount;
  final String code;

  /// How many times the user can still use it.
  final int remaining;

  bool get isAvailable => remaining > 0;

  /// Amount taken off [subtotal]: a percentage for "20%", a flat amount for
  /// "$10". Never more than the subtotal.
  double discountOn(double subtotal) {
    final value =
        double.tryParse(discount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final off = discount.endsWith('%') ? subtotal * value / 100 : value;
    return off.clamp(0, subtotal).toDouble();
  }

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'].toString(),
      discount: json['discount'] as String,
      code: json['code'] as String,
      remaining: (json['remaining'] as num?)?.toInt() ?? 0,
    );
  }
}
