import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/supervisor/task_status.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/network/remote/local_notification_statuses.dart';

class LocalNotifications {
  static final _notification = FlutterLocalNotificationsPlugin();
  static Future<void> initialize(GlobalKey<NavigatorState> navigator) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _notification.initialize(initializationSettings,
        onSelectNotification: ((data) {
      if (data == null) return;
      final jsonDecode = json.decode(data) as Map<String, dynamic>;

      final order = OrderModel.fromMap(json.decode(jsonDecode['order_id']));
      log(order.totalPrice.toString());
      log('From local notification');
      if (jsonDecode.containsKey('order_id')) {
        final status = order.status;
        Task task;
        switch (status) {
          case 'new':
            task = const ActiveEmployeeTask(15, 12);
            break;
          case 'process':
            task = const PendingEmployeeTask(15, 12);
            break;
          case 'end':
            task = const FinishedTask();
            break;
          default:
            task = const FinishedTask();
        }
        navigator.currentState!.push(MaterialPageRoute(
          builder: (context) => OrderDetails(
            taskStatus: task,
            order: order,
            homeCubit: HomeCubit(context),
          ),
        ));
      }
    }));
  }

  static Future showLocalNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required LocalNotificationProperties properties}) async {
    log(properties.notificationSoundPath);
    _notification.show(math.Random.secure().nextInt(10), title, body,
        await properties.notificationDetails(),
        payload: payload);
  }
}
