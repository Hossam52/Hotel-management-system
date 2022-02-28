import 'dart:convert';

import 'package:flutter/foundation.dart';

class SupervisorEmployeeModel {
  int id;
  String name;
  String email;
  String block;
  String image;
  List<EmployeeResponsibilitiesModel> res;
  bool isBlocked;
  SupervisorEmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.block,
    required this.image,
    required this.res,
  }) : isBlocked = block == 'unblocked';

  SupervisorEmployeeModel copyWith({
    int? id,
    String? name,
    String? email,
    String? block,
    String? image,
    List<EmployeeResponsibilitiesModel>? res,
  }) {
    return SupervisorEmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      block: block ?? this.block,
      image: image ?? this.image,
      res: res ?? this.res,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'block': block,
      'image': image,
      'res': res.map((x) => x.toMap()).toList(),
    };
  }

  factory SupervisorEmployeeModel.fromMap(Map<String, dynamic> map) {
    return SupervisorEmployeeModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      block: map['block'] ?? '',
      image: map['image'] ?? '',
      res: List<EmployeeResponsibilitiesModel>.from(
          map['res']?.map((x) => EmployeeResponsibilitiesModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupervisorEmployeeModel.fromJson(String source) =>
      SupervisorEmployeeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SupervisorEmployeeModel(id: $id, name: $name, email: $email, block: $block, image: $image, res: $res)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupervisorEmployeeModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.block == block &&
        other.image == image &&
        listEquals(other.res, res);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        block.hashCode ^
        image.hashCode ^
        res.hashCode;
  }
}

class EmployeeResponsibilitiesModel {
  int id;
  String unit;
  String floor;
  int form_room;
  int to_room;
  EmployeeResponsibilitiesModel({
    required this.id,
    required this.unit,
    required this.floor,
    required this.form_room,
    required this.to_room,
  });

  EmployeeResponsibilitiesModel copyWith({
    int? id,
    String? unit,
    String? floor,
    int? form_room,
    int? to_room,
  }) {
    return EmployeeResponsibilitiesModel(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      floor: floor ?? this.floor,
      form_room: form_room ?? this.form_room,
      to_room: to_room ?? this.to_room,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit,
      'floor': floor,
      'form_room': form_room,
      'to_room': to_room,
    };
  }

  factory EmployeeResponsibilitiesModel.fromMap(Map<String, dynamic> map) {
    return EmployeeResponsibilitiesModel(
      id: map['id']?.toInt() ?? 0,
      unit: map['unit'] ?? '',
      floor: map['floor'] ?? '',
      form_room: map['form_room'] ?? '',
      to_room: map['to_room'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeResponsibilitiesModel.fromJson(String source) =>
      EmployeeResponsibilitiesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmployeeResponsibilitiesModel(id: $id, unit: $unit, floor: $floor, form_room: $form_room, to_room: $to_room)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeResponsibilitiesModel &&
        other.id == id &&
        other.unit == unit &&
        other.floor == floor &&
        other.form_room == form_room &&
        other.to_room == to_room;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unit.hashCode ^
        floor.hashCode ^
        form_room.hashCode ^
        to_room.hashCode;
  }
}
