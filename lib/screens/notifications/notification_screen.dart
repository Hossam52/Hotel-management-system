import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/models/notifications/notification_model.dart';
import 'package:htask/screens/notifications/cubit/notification_cubit.dart';
import 'package:htask/screens/notifications/cubit/notification_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/error_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) =>
              NotificationCubit()..getAllNotifications(context),
          lazy: false,
          child: BlocConsumer<NotificationCubit, NotificationStates>(
            listener: (context, state) {
              if (state is ErrorNotificationState) showErrorToast(state.error);
            },
            builder: (context, state) {
              final notification =
                  NotificationCubit.instance(context).notifications;
              if (state is LoadingNotificationState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ErrorNotificationState) {
                return DefaultErrorWidget(
                  refreshMethod: () => NotificationCubit.instance(context)
                      .getAllNotifications(context),
                  textColor: AppColors.blue1,
                );
              }

              final data = notification!.notifications!.data!;
              return Column(
                children: [
                  // TextButton(
                  //     onPressed: () {
                  //       NotificationCubit.instance(context)
                  //           .getNextPage(context);
                  //     },
                  //     child: Text('Press')),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        return _NotificationItem(notification: data[index]);
                      },
                      itemCount: data.length,
                      separatorBuilder: (_, index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({Key? key, required this.notification})
      : super(key: key);
  final NotificationData notification;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notification.title!,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  notification.body!,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}