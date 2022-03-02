import 'dart:convert';

class DeleteNotifyRequest {
  int notify_id;
  DeleteNotifyRequest({
    required this.notify_id,
  });

  DeleteNotifyRequest copyWith({
    int? notify_id,
  }) {
    return DeleteNotifyRequest(
      notify_id: notify_id ?? this.notify_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notify_id': notify_id,
    };
  }

  factory DeleteNotifyRequest.fromMap(Map<String, dynamic> map) {
    return DeleteNotifyRequest(
      notify_id: map['notify_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteNotifyRequest.fromJson(String source) =>
      DeleteNotifyRequest.fromMap(json.decode(source));

  @override
  String toString() => 'DeleteNotifyRequest(notify_id: $notify_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeleteNotifyRequest && other.notify_id == notify_id;
  }

  @override
  int get hashCode => notify_id.hashCode;
}

class DeleteNotifyResponse {}
