import 'dart:convert';

import 'package:flutter/foundation.dart';

class AllEmployeesToAssign {
  final bool status;
  List<AvailableEmployeeToAssign> employees;
  AllEmployeesToAssign({
    required this.status,
    required this.employees,
  });

  AllEmployeesToAssign copyWith({
    bool? status,
    List<AvailableEmployeeToAssign>? employees,
  }) {
    return AllEmployeesToAssign(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'employees': employees.map((x) => x.toMap()).toList(),
    };
  }

  factory AllEmployeesToAssign.fromMap(Map<String, dynamic> map) {
    return AllEmployeesToAssign(
      status: map['status'] ?? false,
      employees: List<AvailableEmployeeToAssign>.from(
          map['employees']?.map((x) => AvailableEmployeeToAssign.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllEmployeesToAssign.fromJson(String source) =>
      AllEmployeesToAssign.fromMap(json.decode(source));

  @override
  String toString() =>
      'AllEmployeesToAssign(status: $status, employees: $employees)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllEmployeesToAssign &&
        other.status == status &&
        listEquals(other.employees, employees);
  }

  @override
  int get hashCode => status.hashCode ^ employees.hashCode;
}

class AvailableEmployeeToAssign {
  int id;
  String name;
  String image;
  int orderNum;
  AvailableEmployeeToAssign({
    required this.id,
    required this.name,
    required this.image,
    required this.orderNum,
  });

  AvailableEmployeeToAssign copyWith({
    int? id,
    String? name,
    String? image,
    int? orderNum,
  }) {
    return AvailableEmployeeToAssign(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      orderNum: orderNum ?? this.orderNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'orderNum': orderNum,
    };
  }

  factory AvailableEmployeeToAssign.fromMap(Map<String, dynamic> map) {
    return AvailableEmployeeToAssign(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      orderNum: map['orderNum']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableEmployeeToAssign.fromJson(String source) =>
      AvailableEmployeeToAssign.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AvailableEmployeeToAssign(id: $id, name: $name, image: $image, orderNum: $orderNum)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvailableEmployeeToAssign &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.orderNum == orderNum;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image.hashCode ^ orderNum.hashCode;
  }
}

class GetAvaEmployeesRequest {
  String roomID;
  String seID;
  GetAvaEmployeesRequest({
    required this.roomID,
    required this.seID,
  });

  GetAvaEmployeesRequest copyWith({
    String? roomID,
    String? seID,
  }) {
    return GetAvaEmployeesRequest(
      roomID: roomID ?? this.roomID,
      seID: seID ?? this.seID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomID': roomID,
      'seID': seID,
    };
  }

  factory GetAvaEmployeesRequest.fromMap(Map<String, dynamic> map) {
    return GetAvaEmployeesRequest(
      roomID: map['roomID'] ?? '',
      seID: map['seID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAvaEmployeesRequest.fromJson(String source) =>
      GetAvaEmployeesRequest.fromMap(json.decode(source));

  @override
  String toString() => 'GetAvaEmployeesRequest(roomID: $roomID, seID: $seID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAvaEmployeesRequest &&
        other.roomID == roomID &&
        other.seID == seID;
  }

  @override
  int get hashCode => roomID.hashCode ^ seID.hashCode;
}
