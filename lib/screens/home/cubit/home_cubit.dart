import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/categories/all_categories_model.dart';
import 'package:htask/models/categories/category_request_model.dart';
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
import 'package:htask/screens/staff/assign_staff_employee_to_order.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/shared/constants.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';
import 'package:time_range_picker/time_range_picker.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit instance(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  final List<TabBarItem> tabBars = [
    TabBarItem(
        isSelected: true,
        text: 'Active',
        imagePath: 'assets/images/icons/active.svg',
        widget: const ActiveWidget()),
    TabBarItem(
        isSelected: false,
        text: 'Pending',
        imagePath: 'assets/images/icons/pending.svg',
        widget: const PendingWidget()),
    TabBarItem(
        isSelected: false,
        text: 'Finished',
        imagePath: 'assets/images/icons/finished.svg',
        widget: const FinishedWidget()),
    // TabBarItem(
    //     isSelected: false,
    //     text: 'Late',
    //     imagePath: 'assets/images/icons/finished.svg',
    //     widget: const LateWidget()),
  ];
  DateTime? filterByDate;
  TimeRange? filterByTime;
  late AllOrderStatusesModel allOrders;
  late AllCategoriesModel allCategories;

  int selectedTabIndex = 0;
  int? selectedCategoryIndex;
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

//////APIS
  Future<void> getAllOrders(
    BuildContext context,
  ) async {
    final loginAuthType = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    DateTime? searchedFilterDate = filterByDate;
    if (filterByTime != null && filterByDate == null) {
      searchedFilterDate = DateTime.now();
    }
    final date = searchedFilterDate != null
        ? formatDateWithoutTime(searchedFilterDate)
        : null;
    log('Selected date is $date');
    final categoryId = selectedCategoryIndex != null
        ? allCategories.categories[selectedCategoryIndex!].id
        : null;
    try {
      emit(LoadingAllOrdersHomeState());
      allOrders = await _callApiToGetOrders(
        loginAuthType!,
        token,
        requestModel: CategoryRequestModel(
          date: date,
          categoryId: categoryId,
          from:
              filterByTime == null ? null : formatTime(filterByTime!.startTime),
          to: filterByTime == null ? null : formatTime(filterByTime!.endTime),
        ),
      );
      log(allOrders.newStatus.toString());
      emit(SuccessAllOrdersHomeState());
    } catch (e) {
      emit(ErrorAllOrdersHomeState(e.toString()));
    }
  }

  Future<AllOrderStatusesModel> _callApiToGetOrders(
      LoginAuthType authType, String token,
      {CategoryRequestModel? requestModel}) async {
    log(requestModel.toString());
    if (authType == LoginAuthType.employee) {
      return await EmployeeServices.getOrders(token,
          requestModel: requestModel);
    }
    if (authType == LoginAuthType.supervisor) {
      return await SupervisorSurvices.getOrders(token,
          requestModel: requestModel);
    } else {
      throw Exception('Unknown type');
    }
  }

  Future<void> getAllCategories(BuildContext context) async {
    final token = AppCubit.instance(context).token;
    final authType = AppCubit.instance(context).currentUserType!;
    await getAllOrders(context);
    try {
      emit(LoadingAllCategoriesHomeState());
      allCategories = await _callApiToGetCategories(authType, token);
      emit(SuccessAllCategoriesHomeState());
    } catch (e) {
      emit(ErrorAllCategoriesHomeState(e.toString()));
    }
  }

  Future<AllCategoriesModel> _callApiToGetCategories(
      LoginAuthType authType, String token) async {
    if (authType == LoginAuthType.employee) {
      return await SupervisorSurvices.getAllCategories(token);
    } else if (authType == LoginAuthType.supervisor) {
      return await SupervisorSurvices.getAllCategories(token);
    } else {
      throw Exception('Unknown type');
    }
  }

/////////////////End APIS
  void onStatusTapped(BuildContext context, Task task, OrderModel order) async {
    int orderId = order.id;
    final authType = AppCubit.instance(context).currentUserType!;
    final token = AppCubit.instance(context).token;
    if (authType == LoginAuthType.supervisor) {
      if (task is ActiveSupervisorTask) {
        //TO-DO call start task for supervisor
        log('Active supervisor task');
        await SupervisorOrderDetailsCubit.instance(context)
            .changeStatusToProcess(token, orderId);
      } else if (task is PendingSupervisorTask) {
        //TO-DO call change assessment for supervisor
        await SupervisorOrderDetailsCubit.instance(context)
            .changeStatusToEnd(token, orderId);
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

  void changeSelectedCategory(BuildContext context, {int? index}) {
    selectedCategoryIndex = index;
    emit(ChangeCategoryIndexState());
    getAllOrders(context);
    return;
    // if (index == null) {
    //   getAllOrders(context);
    // } else {
    //   final categoryId = allCategories.categories[index].id;
    //   getAllOrders(context, categoryId: categoryId);
    // }
  }

  void changeFilterDate(DateTime? date) {
    filterByDate = date;
    emit(ChangeDateFilterState());
  }

  void changeFilterTimeRange(TimeRange? time) {
    filterByTime = time;
    emit(ChangeDateFilterState());
  }
}
