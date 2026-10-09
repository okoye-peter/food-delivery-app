import 'package:yummy/data/models/cart_item_model.dart';

/// Where an order is, in the order the tracker shows the steps.
enum OrderStatus {
  placed('Order placed', 'We have received your order'),
  preparing('Preparing', 'The kitchen is cooking your meal'),
  onTheWay('On the way', 'Your rider is heading to you'),
  delivered('Delivered', 'Enjoy your meal!');

  const OrderStatus(this.label, this.description);

  final String label;
  final String description;

  bool get isActive => this != delivered;
}

enum PaymentMethod {
  cash('Cash on delivery'),
  card('Debit / credit card'),
  wallet('Yummy wallet');

  const PaymentMethod(this.label);

  final String label;
}

/// What the user thought of a delivered order.
class OrderRating {
  const OrderRating({required this.stars, this.tags = const [], this.comment});

  /// 1 to 5.
  final int stars;

  /// Quick picks such as "Tasty" or "Fast delivery".
  final List<String> tags;
  final String? comment;
}

class OrderModel {
  const OrderModel({
    required this.id,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.placedAt,
    required this.status,
    required this.statusTimes,
    this.deliveryFee = 0,
    this.discount = 0,
    this.voucherCode,
    this.note,
    this.riderName,
    this.riderPhone,
    this.rating,
  });

  final String id;
  final List<CartItemModel> items;
  final String deliveryAddress;
  final PaymentMethod paymentMethod;
  final DateTime placedAt;
  final OrderStatus status;

  /// When the order reached each status it has been through.
  final Map<OrderStatus, DateTime> statusTimes;

  final double deliveryFee;
  final double discount;
  final String? voucherCode;

  /// Instructions for the restaurant, e.g. "No pepper".
  final String? note;

  final String? riderName;
  final String? riderPhone;

  /// Null until the user rates the delivered order.
  final OrderRating? rating;

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  double get total => subtotal + deliveryFee - discount;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get canRate => status == OrderStatus.delivered && rating == null;

  // TODO: use the estimate from the API
  DateTime get estimatedDelivery => placedAt.add(const Duration(minutes: 35));

  OrderModel copyWith({
    OrderStatus? status,
    Map<OrderStatus, DateTime>? statusTimes,
    OrderRating? rating,
  }) => OrderModel(
    id: id,
    items: items,
    deliveryAddress: deliveryAddress,
    paymentMethod: paymentMethod,
    placedAt: placedAt,
    status: status ?? this.status,
    statusTimes: statusTimes ?? this.statusTimes,
    deliveryFee: deliveryFee,
    discount: discount,
    voucherCode: voucherCode,
    note: note,
    riderName: riderName,
    riderPhone: riderPhone,
    rating: rating ?? this.rating,
  );
}
