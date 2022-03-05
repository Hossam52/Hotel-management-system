import 'dart:convert';

class ReadNotificationsModelResponse {
  bool status;
  String message;
  ReadNotificationsModelResponse({
    required this.status,
    required this.message,
  });

  ReadNotificationsModelResponse copyWith({
    bool? status,
    String? message,
  }) {
    return ReadNotificationsModelResponse(
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

  factory ReadNotificationsModelResponse.fromMap(Map<String, dynamic> map) {
    return ReadNotificationsModelResponse(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadNotificationsModelResponse.fromJson(String source) =>
      ReadNotificationsModelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReadNotificationsModelResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReadNotificationsModelResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
