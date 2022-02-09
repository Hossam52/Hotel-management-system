import 'package:flutter/material.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/widgets/defulat_button.dart';

class OrderDetailsActionButton extends StatelessWidget {
  const OrderDetailsActionButton(
      {Key? key,
      required this.taskStatus,
      required this.orderId,
      required this.homeCubit})
      : super(key: key);
  final Task taskStatus;
  final int orderId;
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    if (taskStatus is FinishedTask) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: DefaultButton(
        text: taskStatus.getText(),
        radius: 6,
        onPressed: () => homeCubit.onStatusTapped(context, taskStatus, orderId),
      ),
    );
  }
}
