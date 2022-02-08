import 'dart:convert';

import 'package:htask/models/person_login_model.dart';

class SupervisorLoginModel {
  bool status;
  PersonLoginModel supervisor;
  String token;
  SupervisorLoginModel({
    required this.status,
    required this.supervisor,
    required this.token,
  });

  SupervisorLoginModel copyWith({
    bool? status,
    PersonLoginModel? supervisor,
    String? token,
  }) {
    return SupervisorLoginModel(
      status: status ?? this.status,
      supervisor: supervisor ?? this.supervisor,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'supervisor': supervisor.toMap(),
      'token': token,
    };
  }

  factory SupervisorLoginModel.fromMap(Map<String, dynamic> map) {
    return SupervisorLoginModel(
      status: map['status'] ?? false,
      supervisor: PersonLoginModel.fromMap(map['supervisor']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SupervisorLoginModel.fromJson(String source) =>
      SupervisorLoginModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SupervisorLoginModel(status: $status, supervisor: $supervisor, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupervisorLoginModel &&
        other.status == status &&
        other.supervisor == supervisor &&
        other.token == token;
  }

  @override
  int get hashCode => status.hashCode ^ supervisor.hashCode ^ token.hashCode;
}

// class PersonLoginModel {
//   int id;
//   String name;
//   String email;
//   String image;
//   PersonLoginModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.image,
//   });

//   PersonLoginModel copyWith({
//     int? id,
//     String? name,
//     String? email,
//     String? image,
//   }) {
//     return PersonLoginModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       image: image ?? this.image,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'image': image,
//     };
//   }

//   factory PersonLoginModel.fromMap(Map<String, dynamic> map) {
//     return PersonLoginModel(
//       id: map['id']?.toInt() ?? 0,
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       image: map['image'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PersonLoginModel.fromJson(String source) =>
//       PersonLoginModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'PersonLoginModel(id: $id, name: $name, email: $email, image: $image)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is PersonLoginModel &&
//         other.id == id &&
//         other.name == name &&
//         other.email == email &&
//         other.image == image;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^ name.hashCode ^ email.hashCode ^ image.hashCode;
//   }
// }
