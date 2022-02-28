import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/notifications/notification_model.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/notifications/cubit/notification_states.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(InitialNotificationState());
  static NotificationCubit instance(BuildContext context) =>
      BlocProvider.of<NotificationCubit>(context);
  NotificationsModel? notifications;
  Future<void> getAllNotifications(context) async {
    final notifications = await _getNotificationsAccordingToType(context);
    try {
      emit(LoadingNotificationState());
      this.notifications = notifications;
      emit(SuccessNotificationState());
    } catch (e) {
      emit(ErrorNotificationState(error: e.toString()));
    }
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
}
