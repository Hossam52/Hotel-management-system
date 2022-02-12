import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:htask/models/supervisor/supervisor_employees/supervisor_employee_model.dart';

class SupervisorEmployeesModel {
  bool status;
  List<SupervisorEmployeeModel> categories;
  SupervisorEmployeesModel({
    required this.status,
    required this.categories,
  });

  SupervisorEmployeesModel copyWith({
    bool? status,
    List<SupervisorEmployeeModel>? categories,
  }) {
    return SupervisorEmployeesModel(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory SupervisorEmployeesModel.fromMap(Map<String, dynamic> map) {
    return SupervisorEmployeesModel(
      status: map['status'] ?? false,
      categories: List<SupervisorEmployeeModel>.from(
          map['categories']?.map((x) => SupervisorEmployeeModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupervisorEmployeesModel.fromJson(String source) =>
      SupervisorEmployeesModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SupervisorEmployeesModel(status: $status, categories: $categories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupervisorEmployeesModel &&
        other.status == status &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode => status.hashCode ^ categories.hashCode;
}
