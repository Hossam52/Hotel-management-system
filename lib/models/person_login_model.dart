import 'dart:convert';

class PersonLoginModel {
  int id;
  String name;
  String email;
  String image;
  int orderCashPrice;
  String hotel;
  String currency;
  String hotel_logo;

  PersonLoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.orderCashPrice,
    required this.hotel,
    required this.currency,
    required this.hotel_logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'orderCashPrice': orderCashPrice,
      'image': image,
      'hotel': hotel,
      'currency': currency,
      'hotel_logo': hotel_logo,
    };
  }

  factory PersonLoginModel.fromMap(Map<String, dynamic> map) {
    return PersonLoginModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      orderCashPrice: map['orderCashPrice']?.toInt() ?? 0,
      image: map['image'] ?? '',
      hotel: map['hotel'] ?? '',
      currency: map['currency'] ?? '',
      hotel_logo: map['hotel_logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonLoginModel.fromJson(String source) =>
      PersonLoginModel.fromMap(json.decode(source));

  PersonLoginModel copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
    int? orderCashPrice,
    String? hotel,
    String? currency,
    String? hotel_logo,
  }) {
    return PersonLoginModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      orderCashPrice: orderCashPrice ?? this.orderCashPrice,
      hotel: hotel ?? this.hotel,
      currency: currency ?? this.currency,
      hotel_logo: hotel_logo ?? this.hotel_logo,
    );
  }
}

// class EmployeeData extends PersonLoginModel {
//   EmployeeData(
//       {required this.orderCashPrice, required PersonLoginModel personModel})
//       : super(
//             id: personModel.id,
//             name: personModel.name,
//             email: personModel.email,
//             image: personModel.image,
//             hotel: personModel.hotel,
//             currency: personModel.currency,
//             hotel_logo: personModel.hotel_logo);
//   int orderCashPrice;
//   factory EmployeeData.fromMap(Map<String, dynamic> map) {
//     final personModel = PersonLoginModel.fromMap(map);
//     final orderCashPrice = map['orderCashPrice']?.toInt() ?? 0;
//     return EmployeeData(
//       orderCashPrice: orderCashPrice,
//       personModel: personModel,
//     );
//   }
// }

class EmployeeRequestModel {
  String email;
  String password;
  String code;
  String mobileToken;
  EmployeeRequestModel({
    required this.email,
    required this.password,
    required this.code,
    required this.mobileToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'code': code,
      'mobile_token': mobileToken,
    };
  }
}
