import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/employee_layout/cubit/employee_states.dart';
import 'package:htask/layout/employee_layout/employee_layout.dart';
import 'package:htask/layout/settings_layout/settings_layout.dart';
import 'package:htask/layout/widgets/custom_view_widget.dart';
import 'package:htask/screens/notifications/notification_screen.dart';

class EmployeeCubit extends Cubit<EmployeeStates> {
  EmployeeCubit() : super(InitialEmployeeState());
  static EmployeeCubit instance(context) =>
      BlocProvider.of<EmployeeCubit>(context);
  int selectedTabIndex = 0;
  final _employeeScreens = [
    const HomeEmployee(),
    const CustomWebview(),
    NotificationScreen(),
    const EmployeeSettingsScreen(),
  ];

  void changeSelectedTabIndex(int index) {
    selectedTabIndex = index;
    emit(ChangeSelectedEmployeeTabState());
  }

  Widget getScreen() {
    return _employeeScreens[selectedTabIndex];
  }
}
