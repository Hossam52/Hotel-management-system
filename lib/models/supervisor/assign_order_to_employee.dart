import 'dart:convert';

class AssignOrderToEmployee {
  // bool status;

}

class AssignOrderToEmployeeRequest {
  int orderId;
  int employeeId;
  AssignOrderToEmployeeRequest({
    required this.orderId,
    required this.employeeId,
  });

  AssignOrderToEmployeeRequest copyWith({
    int? orderId,
    int? employeeId,
  }) {
    return AssignOrderToEmployeeRequest(
      orderId: orderId ?? this.orderId,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'employee_id': employeeId,
    };
  }

  factory AssignOrderToEmployeeRequest.fromMap(Map<String, dynamic> map) {
    return AssignOrderToEmployeeRequest(
      orderId: map['order_id']?.toInt() ?? 0,
      employeeId: map['employee_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignOrderToEmployeeRequest.fromJson(String source) =>
      AssignOrderToEmployeeRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'AssignOrderToEmployeeRequest(orderId: $orderId, employeeId: $employeeId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignOrderToEmployeeRequest &&
        other.orderId == orderId &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode => orderId.hashCode ^ employeeId.hashCode;
}
