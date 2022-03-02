import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/notifications/notification_model.dart';
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
  Future<void> getAllNotifications(context) async {
    try {
      emit(LoadingNotificationState());
      final notifications = await _getNotificationsAccordingToType(context);
      this.notifications = notifications;
      emit(SuccessNotificationState());
    } catch (e) {
      emit(ErrorNotificationState(error: e.toString()));
    }
  }

  ScrollController scrollController = ScrollController();
  void _addListener(context) {
    scrollController.addListener(() async {
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
      final newNotifications =
          await _getNextNotificationsPageAccordingToType(context);
      newNotifications;
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
      context) async {
    final nextPage = notifications!.notifications!.meta!.currentPage + 1;
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
}
