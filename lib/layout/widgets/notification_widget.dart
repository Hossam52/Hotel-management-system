import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/widgets/bottom_tab_item.dart';
import 'package:htask/screens/notifications/cubit/notification_states.dart';

import '../../screens/notifications/cubit/notification_cubit.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationCubit = NotificationCubit.instance(context);
    return BlocBuilder<NotificationCubit, NotificationStates>(
      builder: (context, state) {
        if (notificationCubit.notifications == null) {
          return _notification();
        }
        final notificationCount =
            notificationCubit.notifications!.countUnreadNotify;
        return Badge(
            showBadge: notificationCount != 0 || notificationCount == null,
            badgeContent: FittedBox(
              child: Text(
                notificationCount.toString(),
                style: const TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
            badgeColor: Colors.red,
            child: _notification());
      },
    );
  }

  Widget _notification() {
    return const BottomTabItem(
      iconPath: 'assets/images/icons/notification_bottom_tab.svg',
    );
  }
}
