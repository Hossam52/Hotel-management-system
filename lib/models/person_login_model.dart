import 'dart:convert';

class PersonLoginModel {
  int id;
  String name;
  String email;
  String image;
  PersonLoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  PersonLoginModel copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
  }) {
    return PersonLoginModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory PersonLoginModel.fromMap(Map<String, dynamic> map) {
    return PersonLoginModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonLoginModel.fromJson(String source) =>
      PersonLoginModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonLoginModel(id: $id, name: $name, email: $email, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonLoginModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ image.hashCode;
  }
}

class EmployeeRequestModel {
  String email;
  String password;
  String mobileToken;
  EmployeeRequestModel({
    required this.email,
    required this.password,
    required this.mobileToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'mobile_token': mobileToken,
    };
  }
}
