import 'package:flutter/material.dart';
import 'package:htask/screens/home/widgets/statuses_widgets.dart';
import 'package:htask/screens/login/login.dart';

class TabBarItem {
  bool isSelected;
  String text;
  String imagePath;
  Widget widget;
  TabBarItem(
      {required this.isSelected,
      required this.text,
      required this.imagePath,
      required this.widget});
}
