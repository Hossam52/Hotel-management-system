import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/notifications/delete_notification_model.dart';
import 'package:htask/models/notifications/notification_model.dart';
import 'package:htask/models/notifications/read_notifications.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/notifications/cubit/notification_states.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(BuildContext context) : super(InitialNotificationState()) {
    _addListener(context);
  }
  static NotificationCubit instance(BuildContext context) =>
      BlocProvider.of<NotificationCubit>(context);
  NotificationsModel? notifications;
  final Set<int> _selectedNotifications = {};
  void changeSelectedNotification(int notificationId) {
    if (_selectedNotifications.contains(notificationId)) {
      _selectedNotifications.remove(notificationId);
    } else {
      _selectedNotifications.add(notificationId);
    }
    emit(ChangeSelectedNotification(selectedId: notificationId));
  }

  bool get isAllSelected {
    return _selectedNotifications.length ==
        notifications!.notifications!.data!.length;
  }

  bool isNotificationSelected(int notificationId) {
    return _selectedNotifications.contains(notificationId);
  }

  void selectAll() {
    for (var element in notifications!.notifications!.data!) {
      _selectedNotifications.add(element.id!);
    }
    emit(SelectAllNotifications());
  }

  void deselectAllSelected() {
    _selectedNotifications.clear();
    emit(SelectAllNotifications());
  }

  void invertIsSelected() {
    if (isAllSelected) {
      _selectedNotifications.clear();
    } else {
      selectAll();
    }
    emit(DeSelectAllNotifications());
  }

  bool get hasSelectedItems {
    return _selectedNotifications.isNotEmpty;
  }

  Future<void> getAllNotifications(context) async {
    try {
      emit(LoadingNotificationState());
      final notifications = await _getNotificationsAccordingToType(context);
      if (notifications.status == false ||
          notifications.notifications == null) {
        this.notifications =
            NotificationsModel(notifications: Notifications(data: []));
      } else {
        this.notifications = notifications;
      }
      emit(SuccessNotificationState());
    } catch (e) {
      emit(ErrorNotificationState(error: e.toString()));
    }
  }

  ScrollController scrollController = ScrollController();
  void _addListener(context) {
    scrollController.addListener(() async {
      if (state is LoadingMoreNotificationState) return;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      final currentScrollPosition = scrollController.position.pixels;
      const delta = 200;
      if (maxScrollExtent - currentScrollPosition <= delta) {
        await getNextPage(context);
      }
    });
  }

  Future<NotificationsModel> _getNotificationsAccordingToType(context) async {
    final user = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    switch (user) {
      case LoginAuthType.employee:
        return EmployeeServices.getAllNotifications(token);

      case LoginAuthType.supervisor:
        return SupervisorSurvices.getAllNotifications(token);
      default:
        throw Exception('Un defined type');
    }
  }

  Future<void> getNextPage(context) async {
    try {
      if (notifications == null) {
        return;
      }
      final currentNotifications = notifications!.notifications!;
      final currentPage = currentNotifications.meta!.currentPage;
      final lastPage = currentNotifications.meta!.lastPage;
      log('current page $currentPage last page$lastPage');
      if (currentPage == lastPage) return;

      emit(LoadingMoreNotificationState());
      final newNotifications = await _getNextNotificationsPageAccordingToType(
          context, currentPage + 1);
      newNotifications;
      notifications!.countUnreadNotify = newNotifications.countUnreadNotify;
      notifications!.notifications = notifications!.notifications!.copyWith(
        meta: newNotifications.notifications!.meta,
        links: newNotifications.notifications!.links,
      );
      notifications!.notifications!.data!.addAll(
        newNotifications.notifications!.data!,
      );
      emit(SuccessMoreNotificationState());
    } catch (e) {
      emit(ErrorMoreNotificationState(error: e.toString()));
    }
  }

  Future<NotificationsModel> _getNextNotificationsPageAccordingToType(
      context, int nextPage) async {
    final user = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    switch (user) {
      case LoginAuthType.employee:
        return EmployeeServices.getNextNotificationPage(token, nextPage);

      case LoginAuthType.supervisor:
        return SupervisorSurvices.getNextNotificationPage(token, nextPage);
      default:
        throw Exception('Un defined type');
    }
  }

  Future<bool> deleteNotification(int id, BuildContext context) async {
    log('id $id');
    try {
      emit(LoadingDeleteNotificationState());
      final res = await _deleteNotificationAccordingToType(context, id);
      final notificationsList = notifications!.notifications!.data!;
      if (notificationsList.length <= 5) getNextPage(context);
      notificationsList.removeWhere(
        (element) => element.id == id,
      );
      emit(SuccessDeleteNotificationState());
      return res.status;
    } catch (e) {
      log(e.toString());
      emit(ErrorDeleteNotificationState(error: e.toString()));
      return false;
    }
  }

  Future<DeleteNotifyResponse> _deleteNotificationAccordingToType(
      context, int notifyId) async {
    final user = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    final DeleteNotifyRequest deleteNotifyRequest =
        DeleteNotifyRequest(notify_id: notifyId);
    switch (user) {
      case LoginAuthType.employee:
        return EmployeeServices.deleteNotification(token, deleteNotifyRequest);

      case LoginAuthType.supervisor:
        return SupervisorSurvices.deleteNotification(
            token, deleteNotifyRequest);
      default:
        throw Exception('Un defined type');
    }
  }

  Future<void> deleteAllSelectedNotifications(context) async {
    for (var notifyId in _selectedNotifications) {
      await deleteNotification(notifyId, context);
    }
    _selectedNotifications.clear();
  }

  Future<bool> readNotifications(BuildContext context) async {
    if (notifications!.countUnreadNotify == null ||
        notifications!.countUnreadNotify == 0) {
      return true;
    } //No need to call api
    try {
      emit(LoadingReadNotificationState());
      final res = await _readNotificationAccordingToType(context);
      log(res.toString());
      notifications!.countUnreadNotify = 0;
      emit(SuccessReadNotificationState());

      return res.status;
    } catch (e) {
      log(e.toString());
      emit(ErrorReadNotificationState(error: e.toString()));
      return false;
    }
  }

  Future<ReadNotificationsModelResponse> _readNotificationAccordingToType(
      context) async {
    final user = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;

    switch (user) {
      case LoginAuthType.employee:
        return EmployeeServices.readNotifications(token);

      case LoginAuthType.supervisor:
        return SupervisorSurvices.readNotifications(token);
      default:
        throw Exception('Un defined type');
    }
  }
}
