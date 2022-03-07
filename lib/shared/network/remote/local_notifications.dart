import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/supervisor/task_status.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/constants/methods.dart';
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
      navigateAccordingToPayloadNotification(data);
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
