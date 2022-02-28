import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/supervisor/task_status.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/order_details/order_details.dart';

class LocalNotifications {
  static final _notification = FlutterLocalNotificationsPlugin();
  static Future<void> initialize(GlobalKey<NavigatorState> navigator) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _notification.initialize(initializationSettings,
        onSelectNotification: ((payload) {
      log('From local notification');
      navigator.currentState!.push(
        MaterialPageRoute(
          builder: (_) => OrderDetails(
            taskStatus: ActiveSupervisorTask(12, 12),
            order: OrderModel(
                id: 1,
                guestName: 'guestName',
                employeeName: 'employeeName',
                supervisorName: 'supervisorName',
                status: 'new',
                roomNum: '500',
                payment: 'Cash',
                floor: '2',
                date: '022-02-28T13:05:40.000000Z',
                endTime: '022-02-28T13:05:40.000000Z',
                actualEndTime: '022-02-28T13:05:40.000000Z',
                orderdetails: [],
                roomId: 4),
            homeCubit: HomeCubit(),
          ),
        ),
      );
    }));
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'Channel_id',
          'Channel name',
          channelDescription: 'Channel description',
          importance: Importance.defaultImportance,
        ),
        iOS: IOSNotificationDetails());
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }
}
