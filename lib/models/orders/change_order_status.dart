import 'dart:convert';

class ChangeOrderStatusModel {
  bool status;
  String message;
  ChangeOrderStatusModel({
    required this.status,
    required this.message,
  });

  ChangeOrderStatusModel copyWith({
    bool? status,
    String? message,
  }) {
    return ChangeOrderStatusModel(
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

  factory ChangeOrderStatusModel.fromMap(Map<String, dynamic> map) {
    return ChangeOrderStatusModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeOrderStatusModel.fromJson(String source) =>
      ChangeOrderStatusModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChangeOrderStatusModel(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeOrderStatusModel &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
