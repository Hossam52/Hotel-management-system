import 'dart:convert';

class OrderDetailModel {
  int id;
  String service;
  String service_id;
  String image;
  String price;
  String quantity;

  OrderDetailModel({
    required this.id,
    required this.service,
    required this.image,
    required this.price,
    required this.quantity,
    required this.service_id,
  });

  OrderDetailModel copyWith(
      {int? id,
      String? service,
      String? image,
      String? price,
      String? quantity,
      String? service_id}) {
    return OrderDetailModel(
        id: id ?? this.id,
        service: service ?? this.service,
        image: image ?? this.image,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        service_id: service_id ?? this.service_id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service': service,
      'image': image,
      'price': price,
      'quantity': quantity,
      'service_id': service_id,
    };
  }

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
        id: map['id']?.toInt() ?? 0,
        service: map['service'] ?? '',
        image: map['iameg'] ?? '',
        price: map['price'] ?? 0.0,
        quantity: map['quantity'] ?? '',
        service_id: map['service_id'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailModel.fromJson(String source) =>
      OrderDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetailModel(id: $id, service: $service,service_id: $service_id image: $image, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetailModel &&
        other.id == id &&
        other.service == service &&
        other.image == image &&
        other.price == price &&
        other.quantity == quantity &&
        other.service_id == service_id;
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
