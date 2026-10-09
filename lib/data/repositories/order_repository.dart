import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/data/models/cart_item_model.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/models/voucher_model.dart';

/// The user's orders. Listen to it to rebuild when one is placed, moves to
/// the next status or is rated.
// TODO: load orders from the API and get status updates from it
class OrderRepository extends ChangeNotifier {
  OrderRepository._() {
    _orders.addAll(buildDummyOrders(DateTime.now()));
  }

  static final instance = OrderRepository._();

  // TODO: get the fee from the API
  static const deliveryFee = 2.0;

  /// Demo only: how often orders placed in the app move to the next status,
  /// so the tracker can be seen working without a backend.
  static const _simulatedStepInterval = Duration(seconds: 20);

  final _orders = <OrderModel>[];
  final _simulatedIds = <String>{};
  Timer? _simulationTimer;

  /// Newest first.
  List<OrderModel> get orders =>
      [..._orders]..sort((a, b) => b.placedAt.compareTo(a.placedAt));

  List<OrderModel> get activeOrders =>
      orders.where((o) => o.status.isActive).toList();

  List<OrderModel> get pastOrders =>
      orders.where((o) => !o.status.isActive).toList();

  OrderModel? findById(String id) =>
      _orders.where((o) => o.id == id).firstOrNull;

  OrderModel place({
    required List<CartItemModel> items,
    required String deliveryAddress,
    required PaymentMethod paymentMethod,
    VoucherModel? voucher,
    String? note,
  }) {
    final now = DateTime.now();
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.total);
    final order = OrderModel(
      id: 'YM${1049 + _orders.length}',
      items: items,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      placedAt: now,
      status: OrderStatus.placed,
      statusTimes: {OrderStatus.placed: now},
      deliveryFee: deliveryFee,
      discount: voucher?.discountOn(subtotal) ?? 0,
      voucherCode: voucher?.code,
      note: (note?.trim().isEmpty ?? true) ? null : note!.trim(),
      // TODO: the API assigns the rider
      riderName: 'Tunde Bakare',
      riderPhone: '+234 801 234 5678',
    );
    _orders.add(order);
    _simulatedIds.add(order.id);
    _simulationTimer ??= Timer.periodic(
      _simulatedStepInterval,
      (_) => _advanceSimulatedOrders(),
    );
    notifyListeners();
    return order;
  }

  void rate(String orderId, OrderRating rating) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index == -1) return;
    _orders[index] = _orders[index].copyWith(rating: rating);
    notifyListeners();
  }

  void _advanceSimulatedOrders() {
    final now = DateTime.now();
    for (final id in [..._simulatedIds]) {
      final index = _orders.indexWhere((o) => o.id == id);
      final order = _orders[index];
      final next = OrderStatus.values[order.status.index + 1];
      _orders[index] = order.copyWith(
        status: next,
        statusTimes: {...order.statusTimes, next: now},
      );
      if (!next.isActive) _simulatedIds.remove(id);
    }
    if (_simulatedIds.isEmpty) {
      _simulationTimer?.cancel();
      _simulationTimer = null;
    }
    notifyListeners();
  }
}
