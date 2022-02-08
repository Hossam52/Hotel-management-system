import 'dart:convert';

class GuestModel {
  int id;
  String name;
  String phone;
  String checkIn;
  String checkout;
  GuestModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.checkIn,
    required this.checkout,
  });

  GuestModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? checkIn,
    String? checkout,
  }) {
    return GuestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      checkIn: checkIn ?? this.checkIn,
      checkout: checkout ?? this.checkout,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'checkin': checkIn,
      'checkout': checkout,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      checkIn: map['checkin'] ?? '',
      checkout: map['checkout'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestModel.fromJson(String source) =>
      GuestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GuestModel(id: $id, name: $name, phone: $phone, checkIn: $checkIn, checkout: $checkout)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GuestModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.checkIn == checkIn &&
        other.checkout == checkout;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        checkIn.hashCode ^
        checkout.hashCode;
  }
}
