import 'package:flutter/material.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/constants.dart';

import 'package:htask/styles/colors.dart';

class StatusItem extends StatelessWidget {
  const StatusItem(
      {Key? key, required this.statusImagePath, required this.taskStatus})
      : super(key: key);
  final String statusImagePath;
  final Task taskStatus;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(
          context,
          OrderDetails(
            taskStatus: taskStatus,
          )),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.25),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _rowRecord(
                item1:
                    _RowItemModel(text: '1', imagePath: 'assets/images/id.png'),
                item2: _RowItemModel(
                    text: '12 min left', imagePath: statusImagePath),
              ),
              _rowRecord(
                item1: _RowItemModel(text: '3 Washing orders'),
                item2: _RowItemModel(
                    text: '210 L.E', imagePath: 'assets/images/cash.png'),
              ),
              _rowRecord(
                item1: _RowItemModel(
                    text: '12', imagePath: 'assets/images/door.png'),
                item2: _RowItemModel(
                    text: 'Ahmed Mohamed', imagePath: 'assets/images/user.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowRecord({
    required _RowItemModel item1,
    required _RowItemModel item2,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _rowItem(item1.imagePath, item1.text)),
            Expanded(child: _rowItem(item2.imagePath, item2.text)),
          ],
        ),
        const Divider(
          color: AppColors.white,
          thickness: 1,
        )
      ],
    );
  }

  Widget _rowItem(String? imagePath, String text) {
    return Row(
      children: [
        if (imagePath != null) Image.asset(imagePath),
        const SizedBox(
          width: 10,
        ),
        Text(text),
      ],
    );
  }
}

class _RowItemModel {
  String? imagePath;
  String text;
  _RowItemModel({
    this.imagePath,
    required this.text,
  });
}
