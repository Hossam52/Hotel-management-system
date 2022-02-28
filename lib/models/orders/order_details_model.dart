import 'dart:convert';

class OrderDetailModel {
  int id;
  String service;
  int service_id;
  String image;
  int price;
  int quantity;
  OrderDetailModel({
    required this.id,
    required this.service,
    required this.service_id,
    required this.image,
    required this.price,
    required this.quantity,
  });

  OrderDetailModel copyWith({
    int? id,
    String? service,
    int? service_id,
    String? image,
    int? price,
    int? quantity,
  }) {
    return OrderDetailModel(
      id: id ?? this.id,
      service: service ?? this.service,
      service_id: service_id ?? this.service_id,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service': service,
      'service_id': service_id,
      'image': image,
      'price': price,
      'quentity': quantity,
    };
  }

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      id: map['id']?.toInt() ?? 0,
      service: map['service'] ?? '',
      service_id: map['service_id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quentity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailModel.fromJson(String source) =>
      OrderDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetailModel(id: $id, service: $service, service_id: $service_id, image: $image, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetailModel &&
        other.id == id &&
        other.service == service &&
        other.service_id == service_id &&
        other.image == image &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        service.hashCode ^
        service_id.hashCode ^
        image.hashCode ^
        price.hashCode ^
        quantity.hashCode;
  }
}
