import 'dart:convert';

import 'package:htask/models/orders/orders_status_model.dart';

class AllOrderStatusesModel {
  bool status;
  OrderStatusModel newStatus;
  OrderStatusModel processStatus;
  OrderStatusModel endStatus;
  OrderStatusModel lateStatus;
  AllOrderStatusesModel({
    required this.status,
    required this.newStatus,
    required this.processStatus,
    required this.endStatus,
    required this.lateStatus,
  });

  AllOrderStatusesModel copyWith({
    bool? status,
    OrderStatusModel? newStatus,
    OrderStatusModel? processStatus,
    OrderStatusModel? endStatus,
    OrderStatusModel? lateStatus,
  }) {
    return AllOrderStatusesModel(
      status: status ?? this.status,
      newStatus: newStatus ?? this.newStatus,
      processStatus: processStatus ?? this.processStatus,
      endStatus: endStatus ?? this.endStatus,
      lateStatus: lateStatus ?? this.lateStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'new': newStatus.toMap(),
      'process': processStatus.toMap(),
      'end': endStatus.toMap(),
      'late': lateStatus.toMap(),
    };
  }

  factory AllOrderStatusesModel.fromMap(Map<String, dynamic> map) {
    return AllOrderStatusesModel(
      status: map['status'] ?? false,
      newStatus: OrderStatusModel.fromMap(map['new']),
      processStatus: OrderStatusModel.fromMap(map['process']),
      endStatus: OrderStatusModel.fromMap(map['end']),
      lateStatus: OrderStatusModel.fromMap(map['late']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrderStatusesModel.fromJson(String source) =>
      AllOrderStatusesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllOrderStatusesModel(status: $status, newStatus: $newStatus, processStatus: $processStatus, endStatus: $endStatus, late: $lateStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllOrderStatusesModel &&
        other.status == status &&
        other.newStatus == newStatus &&
        other.processStatus == processStatus &&
        other.endStatus == endStatus &&
        other.lateStatus == lateStatus;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        newStatus.hashCode ^
        processStatus.hashCode ^
        endStatus.hashCode ^
        lateStatus.hashCode;
  }
}
