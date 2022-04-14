import 'dart:convert';

import 'package:htask/models/orders/orders_status_model.dart';

class AllOrderStatusesModel {
  bool status;
  OrderStatusModel orders;
  AllOrderStatusesModel({required this.status, required this.orders});

  AllOrderStatusesModel copyWith({
    bool? status,
    OrderStatusModel? orders,
  }) {
    return AllOrderStatusesModel(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'orders': orders.toMap(),
    };
  }

  factory AllOrderStatusesModel.fromMap(Map<String, dynamic> map) {
    return AllOrderStatusesModel(
      status: map['status'] ?? false,
      orders: OrderStatusModel.fromMap(map['orders']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrderStatusesModel.fromJson(String source) =>
      AllOrderStatusesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllOrderStatusesModel(status: $status,  orders: $orders)';
  }
}
