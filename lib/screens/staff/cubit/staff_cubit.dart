import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/supervisor/all_employees_to_assign.dart';
import 'package:htask/screens/staff/cubit/staff_state.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

class StaffCubit extends Cubit<StaffStates> {
  StaffCubit() : super(InitalStaffState());
  static StaffCubit instance(BuildContext context) =>
      BlocProvider.of<StaffCubit>(context);
  late AllEmployeesToAssign allEmployeesToAssign;
  Future<void> getAllStaffToAssign(
      BuildContext context, String roomId, int seID) async {
    final token = AppCubit.instance(context).token;
    try {
      emit(LoadingAllEmployeesToAssignStaffState());
      final res = await SupervisorSurvices.getAllEmployees(
        token,
        GetAvaEmployeesRequest(
          roomID: roomId,
          seID: seID.toString(),
        ),
      );
      allEmployeesToAssign = res;
      emit(SuccessAllEmployeesToAssignStaffState());
    } catch (e) {
      emit(ErrorllEmployeesToAssignStaffState(e.toString()));
    }
  }
}
