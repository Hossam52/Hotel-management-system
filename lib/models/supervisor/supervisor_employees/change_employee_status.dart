import 'dart:convert';

class ChangeEmployeeStatusModel {
  bool status;
  String message;
  ChangeEmployeeStatusModel({
    required this.status,
    required this.message,
  });

  ChangeEmployeeStatusModel copyWith({
    bool? status,
    String? message,
  }) {
    return ChangeEmployeeStatusModel(
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

  factory ChangeEmployeeStatusModel.fromMap(Map<String, dynamic> map) {
    return ChangeEmployeeStatusModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeEmployeeStatusModel.fromJson(String source) =>
      ChangeEmployeeStatusModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChangeEmployeeStatusModel(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeEmployeeStatusModel &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
