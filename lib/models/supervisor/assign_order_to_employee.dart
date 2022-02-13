import 'dart:convert';

class AssignOrderToEmployee {
  bool status;
  String message;
  AssignOrderToEmployee({
    required this.status,
    required this.message,
  });

  AssignOrderToEmployee copyWith({
    bool? status,
    String? message,
  }) {
    return AssignOrderToEmployee(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory AssignOrderToEmployee.fromMap(Map<String, dynamic> map) {
    return AssignOrderToEmployee(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignOrderToEmployee.fromJson(String source) =>
      AssignOrderToEmployee.fromMap(json.decode(source));

  @override
  String toString() =>
      'AssignOrderToEmployee(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignOrderToEmployee &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
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
