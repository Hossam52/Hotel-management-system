import 'dart:convert';
import 'dart:convert';

import 'package:htask/models/person_login_model.dart';

// abstract class LoginType {
//   Map<String, dynamic> toMap();

//   LoginType.fromMap(Map<String, dynamic> map);
//   // void fromMap(Map<String,dynamic>map);
// }

// // class SupervisorType extends LoginType {}

// class EmployeeType extends LoginType {
//   late Employee employee;
//   @override
//   EmployeeType.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
//     employee = EmployeeType.fromMap(map);
//   }
//   @override
//   Map<String, dynamic> toMap() {
//     return employee.toMap();
//   }

//   @override
//   void fromMap(Map<String, dynamic> map) {
//     employee = Employee.fromMap(map);
//   }
// }

class EmployeeLoginModel {
  bool status;
  PersonLoginModel employee;
  String token;
  EmployeeLoginModel({
    required this.status,
    required this.employee,
    required this.token,
  });

  EmployeeLoginModel copyWith({
    bool? status,
    PersonLoginModel? employee,
    String? token,
  }) {
    return EmployeeLoginModel(
      status: status ?? this.status,
      employee: employee ?? this.employee,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'employee': employee.toMap(),
      'token': token,
    };
  }

  factory EmployeeLoginModel.fromMap(Map<String, dynamic> map) {
    return EmployeeLoginModel(
      status: map['status'] ?? false,
      employee: PersonLoginModel.fromMap(map['Employee']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeLoginModel.fromJson(String source) =>
      EmployeeLoginModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'EmployeeLoginModel(status: $status, employee: $employee, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeLoginModel &&
        other.status == status &&
        other.employee == employee &&
        other.token == token;
  }

  @override
  int get hashCode => status.hashCode ^ employee.hashCode ^ token.hashCode;
}
