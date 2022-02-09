import 'package:flutter/material.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/widgets/status_item.dart';
import 'package:htask/widgets/no_data.dart';

class ActiveWidget extends StatelessWidget {
  const ActiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newOrders = HomeCubit.instance(context).allOrders.newStatus;
    final data = newOrders.data;
    return _listView(data, HomeCubit.instance(context).getActiveTask(context));
  }
}

class PendingWidget extends StatelessWidget {
  const PendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newOrders = HomeCubit.instance(context).allOrders.processStatus;
    final data = newOrders.data;
    return _listView(data, HomeCubit.instance(context).getPendingTask(context));
  }
}

class FinishedWidget extends StatelessWidget {
  const FinishedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newOrders = HomeCubit.instance(context).allOrders.endStatus;
    final data = newOrders.data;
    return _listView(data, const FinishedTask());
  }
}

Widget _listView(List<OrderModel> orders, Task task) {
  if (orders.isEmpty) return const NoData();
  return ListView.separated(
    shrinkWrap: true,
    primary: false,
    separatorBuilder: (_, index) => const SizedBox(height: 15),
    itemCount: orders.length,
    itemBuilder: (_, index) => StatusItem(
      orderModel: orders[index],
      taskStatus: task,
      statusImagePath: 'assets/images/completed.png',
    ),
  );
}
