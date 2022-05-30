import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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
  HomeCubit(BuildContext context) : super(InitialHomeState()) {
    _initTabBars();
    _addScrollControllerListeners(context);
  }
  static HomeCubit instance(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  final homeScrollController = ScrollController();
  void _addScrollControllerListeners(context) {
    homeScrollController.addListener(() async {
      if (state is LoadingNextAllOrdersHomeState) {
        return;
      } //Add this to know if there is current loading to get the next page if yes then do nothing else get next page We do this as the thresh hold executes many so we want to eliminate it
      final maxScrollExtent = homeScrollController.position.maxScrollExtent;
      final currentScrollPosition = homeScrollController.position.pixels;
      const delta = 200;
      if (maxScrollExtent - currentScrollPosition <= delta) {
        // await getNextOrdersPage(context);
        tabBars[selectedTabIndex].getMoreData(context);
      }
    });
  }

  void _initTabBars() {
    tabBars = [
      TabBarItem(
          isSelected: true,
          getData: (BuildContext context) async {
            await getAllOrders(context, orderType: 'new');
          },
          getMoreData: (BuildContext context) async {
            await getNextOrdersPage(context, orderType: 'new');
          },
          text: 'Active',
          imagePath: 'assets/images/icons/active.svg',
          widget: const ActiveWidget()),
      TabBarItem(
          isSelected: false,
          getData: (BuildContext context) async {
            await getAllOrders(context, orderType: 'process');
          },
          getMoreData: (BuildContext context) async {
            await getNextOrdersPage(context, orderType: 'process');
          },
          text: 'Pending',
          imagePath: 'assets/images/icons/pending.svg',
          widget: const PendingWidget()),
      TabBarItem(
          isSelected: false,
          getData: (BuildContext context) async {
            await getAllOrders(context, orderType: 'end');
          },
          getMoreData: (BuildContext context) async {
            await getNextOrdersPage(context, orderType: 'end');
          },
          text: 'Finished',
          imagePath: 'assets/images/icons/finished.svg',
          widget: const FinishedWidget()),
      TabBarItem(
          isSelected: false,
          getData: (BuildContext context) async {
            await getAllOrders(context, orderType: 'late');
          },
          getMoreData: (BuildContext context) async {
            await getNextOrdersPage(context, orderType: 'late');
          },
          text: 'Late',
          imagePath: 'assets/images/icons/late.svg',
          widget: const LateWidget()),
    ];
  }

  List<TabBarItem> tabBars = [];
  DateTime? filterByDate;
  TimeRange? filterByTime;
  AllOrderStatusesModel? newOrders;
  AllOrderStatusesModel? processOrders;
  AllOrderStatusesModel? finishedOrders;
  AllOrderStatusesModel? lateOrders;
  late AllCategoriesModel allCategories;
  bool firstGetData = true;

  int selectedTabIndex = 0;
  int? selectedCategoryIndex;
  void changeTabIndex(BuildContext context, int index) {
    selectedTabIndex = index;
    for (int i = 0; i < tabBars.length; i++) {
      tabBars[i].isSelected = false;
    }
    tabBars[index].isSelected = true;

    emit(ChangeTabIndexState());
    tabBars[selectedTabIndex].getData(context);
  }

  List<OrderModel> getActiveOrders() {
    return newOrders!.orders.data;
  }

  List<OrderModel> getPendingOrders() {
    return processOrders!.orders.data;
  }

  List<OrderModel> getFinishedrders() {
    return finishedOrders!.orders.data;
  }

  List<OrderModel> getLateOrders() {
    return lateOrders!.orders.data;
  }

  Future<void> getOrdersPerType(BuildContext context) async {
    tabBars[selectedTabIndex].getData(context);
  }
//////APIS

  Future<void> getAllOrders(BuildContext context,
      {String orderType = 'new'}) async {
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
      final data = await _callApiToGetOrders(
        loginAuthType!,
        token,
        orderType: orderType,
        requestModel: CategoryRequestModel(
          date: date,
          categoryId: categoryId,
          from:
              filterByTime == null ? null : formatTime(filterByTime!.startTime),
          to: filterByTime == null ? null : formatTime(filterByTime!.endTime),
        ),
      );
      if (orderType == 'new') {
        newOrders = data;
      } else if (orderType == 'process') {
        processOrders = data;
      } else if (orderType == 'end') {
        finishedOrders = data;
      } else if (orderType == 'late') {
        lateOrders = data;
      } else {
        throw '';
      }
      firstGetData = false;
      emit(SuccessAllOrdersHomeState());
    } catch (e) {
      emit(ErrorAllOrdersHomeState(e.toString()));
    }
  }

  Future<void> getNextOrdersPage(context, {String orderType = 'new'}) async {
    final loginAuthType = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    DateTime? searchedFilterDate = filterByDate;
    final selectedOrderTypeModel = orderType == 'new'
        ? newOrders
        : orderType == 'process'
            ? processOrders
            : orderType == 'end'
                ? finishedOrders
                : lateOrders;
    final currentOrders = selectedOrderTypeModel!.orders;
    final currentPage = currentOrders.meta.currentPage;
    final lastPage = currentOrders.meta.lastPage;
    log('current page $currentPage last page$lastPage');
    if (currentPage == lastPage) return;
    int? nextPage = currentPage + 1;

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
      emit(LoadingNextAllOrdersHomeState());
      final newOrder = await _callApiToGetOrders(
        loginAuthType!,
        token,
        orderType: orderType,
        page: nextPage,
        requestModel: CategoryRequestModel(
          date: date,
          categoryId: categoryId,
          from:
              filterByTime == null ? null : formatTime(filterByTime!.startTime),
          to: filterByTime == null ? null : formatTime(filterByTime!.endTime),
        ),
      );
      _copyOrderData(newOrder, orderType);
      emit(SuccessNextAllOrdersHomeState());
    } catch (e) {
      emit(ErrorNextAllOrdersHomeState(e.toString()));
    }
  }

  void _copyOrderData(AllOrderStatusesModel commingOrder, String orderType) {
    if (orderType == 'new') {
      newOrders!.orders.data.addAll(
        commingOrder.orders.data,
      );
      newOrders!.orders = newOrders!.orders.copyWith(
        meta: commingOrder.orders.meta,
        links: commingOrder.orders.links,
      );
    }
    if (orderType == 'process') {
      processOrders!.orders.data.addAll(
        commingOrder.orders.data,
      );
      processOrders!.orders = processOrders!.orders.copyWith(
        meta: commingOrder.orders.meta,
        links: commingOrder.orders.links,
      );
    }
    if (orderType == 'end') {
      finishedOrders!.orders.data.addAll(
        commingOrder.orders.data,
      );
      finishedOrders!.orders = finishedOrders!.orders.copyWith(
        meta: commingOrder.orders.meta,
        links: commingOrder.orders.links,
      );
    }
    if (orderType == 'late') {
      lateOrders!.orders.data.addAll(
        commingOrder.orders.data,
      );
      lateOrders!.orders = lateOrders!.orders.copyWith(
        meta: commingOrder.orders.meta,
        links: commingOrder.orders.links,
      );
    }
  }

  Future<AllOrderStatusesModel> _callApiToGetOrders(
      LoginAuthType authType, String token,
      {required String orderType,
      CategoryRequestModel? requestModel,
      int? page}) async {
    log(requestModel.toString());
    if (authType == LoginAuthType.employee) {
      return await EmployeeServices.getOrders(
        token,
        page: page,
        requestModel: requestModel,
        orderType: orderType,
      );
    }
    if (authType == LoginAuthType.supervisor) {
      return await SupervisorSurvices.getOrders(token,
          orderType: orderType, page: page, requestModel: requestModel);
    } else {
      throw Exception('Unknown type');
    }
  }

  Future<void> getAllCategories(BuildContext context) async {
    final token = AppCubit.instance(context).token;
    final authType = AppCubit.instance(context).currentUserType!;
    // await getAllOrders(context);
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
      } else if (task is LateSupervisorTask) {
        //TO-DO call change assessment for supervisor
        await SupervisorOrderDetailsCubit.instance(context)
            .changeStatusToProcess(token, orderId);
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
            .changeStatusToEnd(token, orderId, context);
        //TO-DO call start task for employee

      } else if (task is LateEmployeeTask) {
        log('Late employee task');
        log(orderId.toString());
        await EmployeeOrderDetailsCubit.instance(context)
            .changeStatusToProcess(token, orderId);
        //TO-DO call start task for employee

      } else {
        log('Other');
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

  ActiveTask getLateTask(context) {
    final auth = AppCubit.instance(context).currentUserType;
    if (auth == LoginAuthType.employee) {
      return const LateEmployeeTask(12, 30);
    } else if (auth == LoginAuthType.supervisor) {
      return const LateSupervisorTask(12, 30);
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
    getOrdersPerType(context);
    // getAllOrders(context);
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
