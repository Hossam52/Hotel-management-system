import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:htask/styles/colors.dart';
import 'package:intl/intl.dart';

void showSuccessToast(String msg) {
  Fluttertoast.showToast(msg: msg, backgroundColor: AppColors.doneColor);
}

void showErrorToast(String msg) {
  Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red);
}

void checkResponse(Response res) {
  log(res.toString());
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
