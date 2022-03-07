import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/main.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/constants/constants.dart';
import 'package:htask/styles/colors.dart';
import 'package:intl/intl.dart';

void showSuccessToast(String msg) {
  Fluttertoast.showToast(msg: msg, backgroundColor: AppColors.doneColor);
}

void showErrorToast(String msg) {
  Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red);
}

void checkResponse(Response res) {
  if (!(res.statusCode! >= 200 && res.statusCode! <= 300)) {
    print(res.statusCode);
    if (res.data['message'] != null) {
      throw Exception(res.data['message']);
    } else if (res.data['errors'] != null) {
      Map map = res.data['errors'];
      List list = map.entries.first.value;
      throw Exception(list.first);
    } else {
      throw Exception('Unknown error happened');
    }
  }
}

String formatDateWithoutTime(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatDateWithTime(DateTime date) {
  return DateFormat('yyyy-MM-dd hh:mm').format(date);
}

String formatTime(TimeOfDay time) {
  return '${time.hour}:${time.minute}';
}

Future<String?> get getDeviceToken async {
  log((await FirebaseMessaging.instance.getToken())!);
  return await FirebaseMessaging.instance.getToken();
}

void navigateAccordingToPayloadNotification(
  String? payload,
  // GlobalKey<NavigatorState> navigator
) async {
  final navigator = navigatorKey;
  if (payload == null) return;
  log('payload Before is $payload');
  final jsonDecode = json.decode(payload) as Map<String, dynamic>;
  log('payload Before is $jsonDecode');

  final order = OrderModel.fromMap(json.decode(jsonDecode['order_id']));
  // final order = OrderModel.fromMap(jsonDecode);
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
      case 'late':
        task = const LateEmployeeTask(15, 12);
        break;
      default:
        task = const FinishedTask();
    }
    AppCubit.instance(navigator.currentContext!)
        .currentShowingOrderNotificationScreen();
    await navigator.currentState!.push(
      MaterialPageRoute(
        builder: (context) => OrderDetails(
          taskStatus: task,
          order: order,
          homeCubit: HomeCubit(context),
        ),
      ),
    );
    AppCubit.instance(navigator.currentContext!).closeOrderNotificationScreen();
  }
}
