import 'dart:convert';

class OrderDetailModel {
  int id;
  String service;
  String image;
  String price;
  String quantity;

  OrderDetailModel({
    required this.id,
    required this.service,
    required this.image,
    required this.price,
    required this.quantity,
  });

  OrderDetailModel copyWith({
    int? id,
    String? service,
    String? image,
    String? price,
    String? quantity,
  }) {
    return OrderDetailModel(
      id: id ?? this.id,
      service: service ?? this.service,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service': service,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      id: map['id']?.toInt() ?? 0,
      service: map['service'] ?? '',
      image: map['iameg'] ?? '',
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailModel.fromJson(String source) =>
      OrderDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetailModel(id: $id, service: $service, image: $image, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetailModel &&
        other.id == id &&
        other.service == service &&
        other.image == image &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        service.hashCode ^
        image.hashCode ^
        price.hashCode ^
        quantity.hashCode;
  }
}
