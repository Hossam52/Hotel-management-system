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
        title: const Text('Notifications'),
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
                        .getAllNotifications(context));
              }
              if (notification == null) {
                return const Center(
                    child: Text(
                  'No Data',
                  style: TextStyle(fontSize: 20),
                ));
              }
              final data = notification.notifications!.data!;
              return ListView.separated(
                itemBuilder: (_, index) {
                  return _NotificationItem(notification: data[index]);
                },
                itemCount: data.length,
                separatorBuilder: (_, index) {
                  return const SizedBox(height: 10);
                },
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
        child: Column(
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
      ),
    );
  }
}
