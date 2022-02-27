import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/supervisor_layout/cubit/supervisor_states.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/screens/more/more_screen.dart';
import 'package:htask/screens/notifications/notification_screen.dart';
import 'package:htask/screens/staff/staff.dart';

class SupervisorCubit extends Cubit<SupervisorStates> {
  SupervisorCubit() : super(InitialSupervisorState());
  static SupervisorCubit instance(context) =>
      BlocProvider.of<SupervisorCubit>(context);
  int selectedTabIndex = 0;
  final _supervisorScreens = [
    const SupervisorHome(),
    const StaffScreen(),
    const NotificationScreen(),
    const MoreScreen(),
  ];

  void changeSelectedTabIndex(int index) {
    selectedTabIndex = index;
    emit(ChangeSelectedTabState());
  }

  Widget getScreen() {
    return _supervisorScreens[selectedTabIndex];
  }
}
