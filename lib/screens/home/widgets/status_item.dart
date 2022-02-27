import 'package:flutter/material.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/order_details/order_details.dart';
import 'package:htask/shared/constants.dart';
import 'package:htask/shared/constants/methods.dart';

import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/svg_image_widget.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StatusItem extends StatelessWidget {
  const StatusItem(
      {Key? key,
      required this.statusImagePath,
      required this.taskStatus,
      required this.orderModel})
      : super(key: key);
  final String statusImagePath;
  final Task taskStatus;
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.instance(context);
    final date = DateTime.parse(orderModel.date);
    final actualEndTimeDate = orderModel.actualEndTime != null
        ? DateTime.parse(orderModel.actualEndTime!)
        : null;
    final formattedDate = actualEndTimeDate != null
        ? formatDateWithTime(actualEndTimeDate)
        : formatDateWithTime(date);

    return GestureDetector(
      onTap: () => pushNewScreen(context,
          screen: OrderDetails(
            homeCubit: homeCubit,
            order: orderModel,
            taskStatus: taskStatus,
          ),
          withNavBar: false),
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
                item1: _RowItemModel(
                    text: orderModel.id.toString(),
                    imagePath: 'assets/images/icons/id.svg'),
                item2: _RowItemModel(
                    text: formattedDate, imagePath: statusImagePath),
              ),
              _rowRecord(
                item1:
                    _RowItemModel(text: orderModel.orderdetails.first.service),
                item2: _RowItemModel(
                    text: '${orderModel.totalPrice} L.E',
                    imagePath: 'assets/images/icons/money.svg'),
              ),
              _rowRecord(
                item1: _RowItemModel(
                    text: orderModel.roomNum,
                    imagePath: 'assets/images/icons/door.svg'),
                item2: _RowItemModel(
                    text: orderModel.employeeName,
                    imagePath: 'assets/images/icons/person.svg'),
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
            Flexible(child: _rowItem(item1.imagePath, item1.text)),
            const SizedBox(width: 5),
            Flexible(child: _rowItem(item2.imagePath, item2.text)),
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
        if (imagePath != null)
          SvgImageWidget(path: imagePath, width: 14, height: 14),
        const SizedBox(
          width: 10,
        ),
        Flexible(child: Text(text)),
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
