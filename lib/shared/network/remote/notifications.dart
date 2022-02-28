import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/login/login.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/network/remote/local_notifications.dart';

class FCM {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _firebaseMessaging = FirebaseMessaging.instance;

  // final streamCtlr = StreamController<String>.broadcast();
  // final titleCtlr = StreamController<String>.broadcast();
  // final bodyCtlr = StreamController<String>.broadcast();

  setNotifications(GlobalKey<NavigatorState> navigatorKey) async {
    await LocalNotifications.initialize(navigatorKey);

    FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true);

    log('Start notification');
    // await _notificationOnAppTerminated(navigatorKey);
    await _notificationOnAppBackground(navigatorKey);
    await _notificationOnAppOpened(navigatorKey);

    // await _notificationOnAppOpened(navigatorKey);
    // FirebaseMessaging.onMessage.listen(
    //   (message) async {
    //     log('Notification On Message');
    //     log(message.data.toString());
    //     if (message.data.containsKey('data')) {
    //       log('data ${(message.data['data'] as Map<String, dynamic>)['screen']} ');
    //       // Handle data message
    //       streamCtlr.sink.add(message.data['data']);
    //     }
    //     if (message.data.containsKey('notification')) {
    //       // Handle notification message
    //       streamCtlr.sink.add(message.data['notification']);
    //     }
    //     // Or do other work.
    //     titleCtlr.sink.add(message.notification!.title!);
    //     bodyCtlr.sink.add(message.notification!.body!);
    //   },
    // );
    // // With this token you can test it easily on your phone
    // final token =
    //     _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  Future<void> _notificationOnAppTerminated(
      GlobalKey<NavigatorState> navigatorKey) async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    log('In background found ${message?.data}');
    if (message?.data['order'] == '/order') {
      log('From termination found order');
      navigatorKey.currentState!.push(
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
    }
  }

  Future<void> _notificationOnAppOpened(
      GlobalKey<NavigatorState> navigatorKey) async {
    log((await FirebaseMessaging.instance.getToken())!);
    FirebaseMessaging.onMessage.listen((message) {
      log(message.data.toString());
      log('In onMessage found ${message.data}');
      if (message.data['order'] == '/order') {
        log('From onMessage found order');
        LocalNotifications.showNotification(
            title: message.notification!.title ?? '',
            body: message.notification!.body ?? '',
            payload: message.data['order']);
      }
    });
  }

  Future<void> _notificationOnAppBackground(
      GlobalKey<NavigatorState> navigatorKey) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      log('In background found ${message.data}');
      // await LocalNotifications.showNotification(
      //     title: message.notification!.title ?? '',
      //     body: message.notification!.body ?? '');
      if (message.data['order'] == '/order') {
        log('From termination found order');
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  dispose() {
    // streamCtlr.close();
    // bodyCtlr.close();
    // titleCtlr.close();
  }
}
