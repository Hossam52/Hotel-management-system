import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/supervisor/all_employees_to_assign.dart';
import 'package:htask/models/supervisor/supervisor_employees/supervisor_employee_model.dart';
import 'package:htask/models/supervisor/supervisor_employees/supervisor_employees_model.dart';
import 'package:htask/screens/staff/cubit/staff_state.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

class StaffCubit extends Cubit<StaffStates> {
  StaffCubit() : super(InitalStaffState());
  static StaffCubit instance(BuildContext context) =>
      BlocProvider.of<StaffCubit>(context);
  late AllEmployeesToAssign allEmployeesToAssign;
  late List<SupervisorEmployeeModel> supervisorEmployees;
  SupervisorEmployeeModel getEmployee(int index) {
    return supervisorEmployees[index];
  }

  void toggleIsBlocked(int employeeIndex) {
    final isBlocked = supervisorEmployees[employeeIndex].isBlocked;
    supervisorEmployees[employeeIndex].isBlocked = !isBlocked;
  }

  Future<void> getAllStaffToAssign(
      BuildContext context, String roomId, String seID) async {
    final token = AppCubit.instance(context).token;
    try {
      emit(LoadingAllEmployeesToAssignStaffState());
      final res = await SupervisorSurvices.getAllEmployees(
        token,
        GetAvaEmployeesRequest(
          roomID: roomId,
          seID: seID,
        ),
      );
      if (res.status == false) {
        emit(ErrorllEmployeesToAssignStaffState('No data'));
        return;
      }
      log(res.toString());
      allEmployeesToAssign = res;
      emit(SuccessAllEmployeesToAssignStaffState());
    } catch (e) {
      emit(ErrorllEmployeesToAssignStaffState(e.toString()));
    }
  }

  Future<void> getMyEmployees(BuildContext context) async {
    final token = AppCubit.instance(context).token;
    try {
      emit(LoadingMyEmployeesStaffState());
      final res = await SupervisorSurvices.getMyEmployees(
        token,
      );
      supervisorEmployees = res.categories;
      emit(SuccessMyEmployeesStaffState());
    } catch (e) {
      emit(ErrorMyEmployeesStaffState(e.toString()));
    }
  }

  Future<void> changeEmployeeStatus(
      BuildContext context, int employeeIndex) async {
    final token = AppCubit.instance(context).token;
    final employeeId = getEmployee(employeeIndex).id;
    try {
      emit(ChangingEmployeeStatus());
      final res =
          await SupervisorSurvices.changeEmployeeStatus(token, employeeId);
      if (!res.status) {
        throw Exception(res.message);
      }
      toggleIsBlocked(employeeIndex);
      emit(SuccessChangingEmployeeStatus(res.message));
    } catch (e) {
      emit(ErrorChangingEmployeeStatus(e.toString()));
    }
  }
}
