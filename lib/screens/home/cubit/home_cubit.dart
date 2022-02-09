import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/orders/all_orders_statueses_model.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/orders/orders_status_model.dart';
import 'package:htask/models/supervisor/task_status.dart';
import 'package:htask/models/tab_bar_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/home/widgets/statuses_widgets.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/order_details/cubit/order_details_cubit.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit instance(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  final List<TabBarItem> tabBars = [
    TabBarItem(
        isSelected: true,
        text: 'Active',
        imagePath: 'assets/images/active.png',
        widget: const ActiveWidget()),
    TabBarItem(
        isSelected: false,
        text: 'Pending',
        imagePath: 'assets/images/pending.png',
        widget: const PendingWidget()),
    TabBarItem(
        isSelected: false,
        text: 'Finished',
        imagePath: 'assets/images/finished.png',
        widget: const FinishedWidget()),
  ];

  late AllOrderStatusesModel allOrders;

  int selectedTabIndex = 0;

  void changeTabIndex(int index) {
    selectedTabIndex = index;

    for (int i = 0; i < tabBars.length; i++) {
      tabBars[i].isSelected = false;
    }
    tabBars[index].isSelected = true;

    emit(ChangeTabIndexState());
  }

  List<OrderModel> getActiveOrders() {
    return allOrders.newStatus.data;
  }

  Future<void> getAllOrders(BuildContext context) async {
    final loginAuthType = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    try {
      emit(LoadingAllOrdersHomeState());
      allOrders = await _callApiToGetOrders(loginAuthType!, token);
      emit(SuccessAllOrdersHomeState());
    } on Exception catch (e) {
      emit(ErrorAllOrdersHomeState(e.toString()));
    }
  }

  Future<AllOrderStatusesModel> _callApiToGetOrders(
      LoginAuthType authType, String token) async {
    if (authType == LoginAuthType.employee) {
      return await EmployeeServices.getOrders(token);
    }
    if (authType == LoginAuthType.supervisor) {
      return await SupervisorSurvices.getOrders(token);
    } else {
      throw Exception('Unknown type');
    }
  }

  void onStatusTapped(BuildContext context, Task task, int orderId) async {
    final authType = AppCubit.instance(context).currentUserType!;
    final token = AppCubit.instance(context).token;
    if (authType == LoginAuthType.supervisor) {
      if (task is ActiveSupervisorTask) {
        //TO-DO call start task for supervisor

      } else if (task is PendingSupervisorTask) {
        //TO-DO call change assessment for supervisor

      } else {}
    } else if (authType == LoginAuthType.employee) {
      if (task is ActiveEmployeeTask) {
        log('Active employee task');
        await EmployeeOrderDetailsCubit.instance(context)
            .changeStatusToProcess(token, orderId);
        //TO-DO call start task for employee
      } else if (task is PendingEmployeeTask) {
        log('Pending employee task');
        log(orderId.toString());
        await EmployeeOrderDetailsCubit.instance(context)
            .changeStatusToEnd(token, orderId);
        //TO-DO call start task for employee

      }
    }
  }

  ActiveTask getActiveTask(context) {
    final auth = AppCubit.instance(context).currentUserType;
    if (auth == LoginAuthType.employee) {
      return const ActiveEmployeeTask(12, 30);
    } else if (auth == LoginAuthType.supervisor) {
      return const ActiveSupervisorTask(12, 30);
    } else {
      throw Exception('Unknown auth');
    }
  }

  PendingTask getPendingTask(context) {
    final auth = AppCubit.instance(context).currentUserType;
    if (auth == LoginAuthType.employee) {
      return const PendingEmployeeTask(12, 30);
    } else if (auth == LoginAuthType.supervisor) {
      return const PendingSupervisorTask(12, 30);
    } else {
      throw Exception('Unknown auth');
    }
  }
}
