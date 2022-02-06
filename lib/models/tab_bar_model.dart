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

final List<TabBarItem> tabBars = [
  TabBarItem(
      isSelected: true,
      text: 'Active',
      imagePath: 'assets/images/active.png',
      widget: const ActiveWidget()),
  TabBarItem(
      isSelected: false,
      text: 'Pending',
      imagePath: 'assets/images/pending.png',
      widget: const PendingWidget()),
  TabBarItem(
      isSelected: false,
      text: 'Finished',
      imagePath: 'assets/images/finished.png',
      widget: const FinishedWidget()),
];
