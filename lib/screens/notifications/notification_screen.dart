import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/models/notifications/notification_model.dart';
import 'package:htask/screens/notifications/cubit/notification_cubit.dart';
import 'package:htask/screens/notifications/cubit/notification_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/error_widget.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    NotificationCubit.instance(context).readNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationStates>(
      listener: (context, state) {
        if (state is ErrorNotificationState) showErrorToast(state.error);
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (NotificationCubit.instance(context).hasSelectedItems) {
              NotificationCubit.instance(context).deselectAllSelected();
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Notifications'.tr()),
              centerTitle: true,
              leadingWidth: double.infinity,
              // leading: TextButton.icon(
              //   style: ButtonStyle(
              //     padding: MaterialStateProperty.all(EdgeInsets.zero),
              //   ),
              //   label: const Text(
              //     'Select all',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   onPressed: () {
              //     NotificationCubit.instance(context).invertIsSelected();
              //   },
              //   icon: Checkbox(
              //       fillColor: MaterialStateProperty.all(Colors.green),
              //       value: NotificationCubit.instance(context).isAllSelected,
              //       onChanged: (val) {
              //         NotificationCubit.instance(context).invertIsSelected();
              //       }),
              // ),
              actions: [
                if (NotificationCubit.instance(context).hasSelectedItems)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        NotificationCubit.instance(context)
                            .deleteAllSelectedNotifications(context);
                      },
                      icon: const Icon(Icons.highlight_remove_rounded,
                          color: Colors.red),
                    ),
                  )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(onRefresh: () async {
                      await NotificationCubit.instance(context)
                          .getAllNotifications(context);
                    }, child: Builder(
                      builder: ((context) {
                        final notification =
                            NotificationCubit.instance(context).notifications;
                        if (state is LoadingNotificationState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is ErrorNotificationState) {
                          return DefaultErrorWidget(
                            refreshMethod: () =>
                                NotificationCubit.instance(context)
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
                                controller: NotificationCubit.instance(context)
                                    .scrollController,
                                itemBuilder: (_, index) {
                                  return _NotificationItem(
                                      notification: data[index]);
                                },
                                itemCount: data.length,
                                separatorBuilder: (_, index) {
                                  return const SizedBox(height: 10);
                                },
                              ),
                            ),
                            if (state is LoadingMoreNotificationState)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        );
                      }),
                    )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({Key? key, required this.notification})
      : super(key: key);
  final NotificationData notification;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id!.toString()),
      confirmDismiss: (direction) {
        return NotificationCubit.instance(context)
            .deleteNotification(notification.id!, context);
      },
      child: BlocBuilder<NotificationCubit, NotificationStates>(
        builder: (context, state) {
          final cubit = NotificationCubit.instance(context);
          return Card(
            child: ListTile(
              onLongPress: () {
                cubit.changeSelectedNotification(notification.id!);
              },
              onTap: () {
                if (cubit.hasSelectedItems) {
                  cubit.changeSelectedNotification(notification.id!);
                }
              },
              minLeadingWidth: 0,
              dense: true,
              horizontalTitleGap: 0,
              leading: !cubit.hasSelectedItems
                  ? null
                  : Checkbox(
                      value: cubit.isNotificationSelected(notification.id!),
                      onChanged: (_) {
                        cubit.changeSelectedNotification(notification.id!);
                      }),
              title: Text(
                notification.title!,
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                notification.body!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
              isThreeLine: true,
            ),
          );
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
