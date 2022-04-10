import 'dart:convert';

class PersonLoginModel {
  int id;
  String name;
  String email;
  String image;
  String hotel;
  String currency;
  String hotel_logo;
  PersonLoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.hotel,
    required this.currency,
    required this.hotel_logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
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
      image: map['image'] ?? '',
      hotel: map['hotel'] ?? '',
      currency: map['currency'] ?? '',
      hotel_logo: map['hotel_logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonLoginModel.fromJson(String source) =>
      PersonLoginModel.fromMap(json.decode(source));
}

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
