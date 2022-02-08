import 'dart:convert';

class LogoutModel {
  bool status;
  String message;
  LogoutModel({
    required this.status,
    required this.message,
  });

  LogoutModel copyWith({
    bool? status,
    String? message,
  }) {
    return LogoutModel(
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

  factory LogoutModel.fromMap(Map<String, dynamic> map) {
    return LogoutModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoutModel.fromJson(String source) =>
      LogoutModel.fromMap(json.decode(source));

  @override
  String toString() => 'LogoutModel(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogoutModel &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
