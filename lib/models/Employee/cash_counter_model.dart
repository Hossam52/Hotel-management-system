import 'dart:convert';

class CashCounterModel {
  bool status;
  int orderCashCount;
  CashCounterModel({
    required this.status,
    required this.orderCashCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'orderCashCount': orderCashCount,
    };
  }

  factory CashCounterModel.fromMap(Map<String, dynamic> map) {
    return CashCounterModel(
      status: map['status'] ?? false,
      orderCashCount: map['orderCashCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashCounterModel.fromJson(String source) =>
      CashCounterModel.fromMap(json.decode(source));
}
