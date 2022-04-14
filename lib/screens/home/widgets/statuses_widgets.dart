import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/home/widgets/status_item.dart';
import 'package:htask/widgets/error_widget.dart';
import 'package:htask/widgets/no_data.dart';

class ActiveWidget extends StatelessWidget {
  const ActiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = HomeCubit.instance(context);
        final newOrders = homeCubit.newOrders?.orders.data ?? [];
        return _listView(newOrders, homeCubit.getActiveTask(context));
      },
    );
  }
}

class PendingWidget extends StatelessWidget {
  const PendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = HomeCubit.instance(context);
        final processOrders = homeCubit.processOrders?.orders.data ?? [];
        return _listView(processOrders, homeCubit.getPendingTask(context));
      },
    );
  }
}

class FinishedWidget extends StatelessWidget {
  const FinishedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = HomeCubit.instance(context);
        final finishedOrders = homeCubit.finishedOrders?.orders.data ?? [];
        return _listView(finishedOrders, const FinishedTask());
      },
    );
  }
}

class LateWidget extends StatelessWidget {
  const LateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = HomeCubit.instance(context);
        final lateOrders = homeCubit.lateOrders?.orders.data ?? [];
        return _listView(lateOrders, homeCubit.getLateTask(context));
      },
    );
  }
}

Widget _listView(List<OrderModel> orders, Task task) {
  return BlocBuilder<HomeCubit, HomeState>(
    // buildWhen: (previous, current) => current is SuccessNextAllOrdersHomeState,
    builder: (context, state) {
      log(state.toString());
      if (state is LoadingAllOrdersHomeState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ErrorAllOrdersHomeState) {
        return DefaultErrorWidget(
            refreshMethod: () =>
                HomeCubit.instance(context).getOrdersPerType(context));
      }
      if (orders.isEmpty) return const NoData();
      return ListView.separated(
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (_, index) => const SizedBox(height: 15),
        itemCount: orders.length,
        itemBuilder: (_, index) => StatusItem(
          orderModel: orders[index],
          taskStatus: task,
          statusImagePath: task.getImagePath(),
        ),
      );
    },
  );
}
