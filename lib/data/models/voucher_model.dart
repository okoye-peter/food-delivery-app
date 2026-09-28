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

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'].toString(),
      discount: json['discount'] as String,
      code: json['code'] as String,
      remaining: (json['remaining'] as num?)?.toInt() ?? 0,
    );
  }
}
