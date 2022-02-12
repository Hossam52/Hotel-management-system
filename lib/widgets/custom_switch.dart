import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:htask/styles/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({Key? key, required this.val, required this.onToggle})
      : super(key: key);
  final bool val;
  final void Function(bool) onToggle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 30,
      child: FlutterSwitch(
        activeColor: AppColors.doneColor,
        onToggle: onToggle,
        value: val,
      ),
    );
  }
}
