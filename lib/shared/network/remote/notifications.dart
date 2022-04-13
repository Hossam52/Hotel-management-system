import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:htask/main.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/login/login.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/shared/network/remote/local_notification_statuses.dart';
import 'package:htask/shared/network/remote/local_notifications.dart';
import 'package:htask/shared/network/remote/push_notification_model.dart';

class FCM {
  // static GlobalKey<NavigatorState> navigatorKey;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  setNotifications() async {
    await LocalNotifications.initialize(navigatorKey);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    log('Start notification');
    // await _notificationOnAppBackgroundOrTerminated(navigatorKey);
    await _notificationOnAppTerminated(navigatorKey);
    await _notificationOnAppBackground(navigatorKey);
    await _notificationOnAppOpened(navigatorKey);
  }

  static void _checkRedirection(RemoteMessage message,
      [bool showLocalNotification = true]) {
    log('notification title ${message.notification!.title} body ${message.notification!.title}');
    final data = message.data;

    if (data.containsKey('order_id')) {
      if (!showLocalNotification) {
        navigateAccordingToPayloadNotification(json.encode(data));
      } else {
        final order = OrderModel.fromJson(data['order_id']);
        final isLate = order.status == 'late';
        final isPending = order.status == 'process';
        final isFinished = order.status == 'end';
        final isNewOrder = order.status == 'new';
        LocalNotifications.showLocalNotification(
          properties: isLate
              ? LateOrdersLocalNotification()
              : isFinished
                  ? FinishedOrdersLocalNotification()
                  : isPending
                      ? PendingOrdersLocalNotification()
                      : isNewOrder
                          ? OrdersLocalNotification()
                          : DefaultLocalNotification(),
          title: message.notification!.title, // message.notification!.title,
          body: message.notification!.body, //message.notification!.body,
          payload: json.encode(data),
        );
      }
    } else if (message.data.containsKey('change_available')) {
      LocalNotifications.showLocalNotification(
        properties: ChangeAvailableLocalNotification(),
        title: message.notification!.title, // message.notification!.title,
        body: message.notification!.body, //message.notification!.body,
        payload: json.encode(data),
      );
    } else if (message.data.containsKey('auth')) {
      LocalNotifications.showLocalNotification(
        properties: AuthLocalNotification(),
        title: message.notification!.title, // message.notification!.title,
        body: message.notification!.body, //message.notification!.body,
        payload: json.encode(data),
      );
    } else {
      LocalNotifications.showLocalNotification(
        properties: DefaultLocalNotification(),
        title: message.notification!.title, // message.notification!.title,
        body: message.notification!.body, //message.notification!.body,
        payload: json.encode(data),
      );
    }
  }

  Future<void> _notificationOnAppTerminated(
      GlobalKey<NavigatorState> navigatorKey) async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message == null) return;
    _checkRedirection(message);
  }

  Future<void> _notificationOnAppOpened(
      GlobalKey<NavigatorState> navigatorKey) async {
    FirebaseMessaging.onMessage.listen((message) {
      log('In onMessage found ${message.data}');
      _checkRedirection(message);
    });
  }

  static Future<void> notificationOnAppBackgroundOrTerminated(
      RemoteMessage message) async {
    log('In BackgroundOrTerminated found ${message.data}');
    // _checkRedirection(message, false);
    // navig
    return;
    FirebaseMessaging.onBackgroundMessage((message) async {});
  }

  Future<void> _notificationOnAppBackground(
      GlobalKey<NavigatorState> navigatorKey) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      log('In openedApp found ${message.data}');
      _checkRedirection(message, false);
    });
  }
}
