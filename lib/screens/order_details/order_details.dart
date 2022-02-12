import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/orders/order_details_model.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/order_details/cubit/order_details_cubit.dart';
import 'package:htask/screens/order_details/cubit/order_details_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/defulat_button.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(
      {Key? key,
      required this.taskStatus,
      required this.order,
      required this.homeCubit,
      this.actionWidget})
      : super(key: key);
  final Task taskStatus;
  final OrderModel order;
  final HomeCubit homeCubit;
  final Widget? actionWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightPrimary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarTextStyle: const TextStyle(color: Colors.black),
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          leading: !Navigator.canPop(context) ? null : _backButton(),
          title: const Text(
            'Order details',
            style: TextStyle(fontSize: 14, color: AppColors.darkPrimaryColor),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            // BlocProvider(
            //   create: (context) =>
            //       OrderDetailsCubit.getCurrentUserCubit(context),
            // ),
            BlocProvider(
              create: (context) => SupervisorOrderDetailsCubit(),
              lazy: false,
            ),
            BlocProvider(
              create: (context) => EmployeeOrderDetailsCubit(),
              lazy: false,
            ),
          ],
          child: BlocListener<SupervisorOrderDetailsCubit, OrderDetailsState>(
            listener: (context, state) async {
              if (state is SuccessChangeStatusToProcessState) {
                log(state.message);
                showSuccessToast(state.message);
                Navigator.pop(context);
                await homeCubit.getAllOrders(context);
              } else if (state is LoadingChangeStatusToProcessState) {
                log('Loading');
              } else if (state is ErrorOrderState) {
                showErrorToast(state.error);
                log('Errro ////${state.error}');
              }
            },
            child: BlocConsumer<EmployeeOrderDetailsCubit, OrderDetailsState>(
              listener: (context, state) async {
                if (state is SuccessChangeStatusToProcessState) {
                  log(state.message);
                  showSuccessToast(state.message);
                  Navigator.pop(context);

                  await homeCubit.getAllOrders(context);
                } else if (state is LoadingChangeStatusToProcessState) {
                  log('Loading');
                } else if (state is ErrorOrderState) {
                  showErrorToast(state.error);
                  log('Errro ////${state.error}');
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Time(taskStatus: taskStatus),
                        _PersonalDataStatistics(
                          floor: order.floor,
                          name: order.employeeName,
                          roomNum: order.roomNum,
                          assignedTo: getAssignedToIfSupervisor(context),
                        ),
                        const SizedBox(height: 30),
                        _OrderDetailsItems(orderDetails: order.orderdetails),
                        const SizedBox(height: 30),
                        _Price(price: order.totalPrice),
                        const SizedBox(height: 30),
                        // actionWidget ?? Container()
                        _OrderDetailsActionButton(
                            taskStatus: taskStatus,
                            order: order,
                            onPressed: () => homeCubit.onStatusTapped(
                                context, taskStatus, order),
                            homeCubit: homeCubit)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _backButton() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: const [
            Icon(Icons.arrow_back_ios),
            Text(
              'Back',
              style: TextStyle(fontSize: 14, color: AppColors.darkPrimaryColor),
            )
          ],
        ),
      );
    });
  }

  String? getAssignedToIfSupervisor(BuildContext context) {
    final authType = AppCubit.instance(context).currentUserType!;
    if (authType == LoginAuthType.supervisor) {
      return order.supervisorName;
    } else {
      return null;
    }
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key, required this.taskStatus}) : super(key: key);
  final Task taskStatus;
  @override
  Widget build(BuildContext context) {
    if (taskStatus is FinishedTask) return _done();
    final TimeTask timeTask = taskStatus as TimeTask;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _timeTitle(),
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkPrimaryColor),
        ),
        Center(
          child: Text(
            '${timeTask.currentMinutes} min ${timeTask.currentSeconds} sec',
            style:
                AppTextStyles.textStyle2.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _done() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Done',
          style: TextStyle(
              color: AppColors.doneColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        Image.asset('assets/images/completed.png'),
      ],
    );
  }

  String _timeTitle() {
    if (taskStatus is ActiveTask) {
      return 'Estimated time';
    } else if (taskStatus is PendingTask) {
      return 'Remaining estimated';
    }
    return '';
  }
}

class _PersonalDataStatistics extends StatelessWidget {
  const _PersonalDataStatistics(
      {Key? key,
      this.assignedTo,
      required this.name,
      required this.roomNum,
      this.floor})
      : super(key: key);
  final String? assignedTo;
  final String name;
  final String roomNum;
  final String? floor;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _name(),
            if (floor == null) Center(child: _roomNumber(roomNum)),
            if (floor != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _roomNumber(roomNum),
                  _floor(floor!),
                ],
              ),
            if (assignedTo != null)
              SizedBox(
                height: height * 0.06,
              ),
            _assignedTo(),
          ],
        ),
      ),
    );
  }

  Widget _name() {
    return Row(children: [
      Image.asset('assets/images/user.png'),
      const SizedBox(width: 10),
      RichText(
        text: TextSpan(
            text: 'Mr ',
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(text: name, style: const TextStyle(fontSize: 19)),
            ]),
      )
    ]);
  }

  Widget _roomNumber(String number) {
    const TextStyle roomNumberTextStyle =
        TextStyle(color: AppColors.darkPrimaryColor, fontSize: 16);
    return Column(
      children: [
        Text(
          number,
          style: roomNumberTextStyle.copyWith(
              fontSize: 90, fontWeight: FontWeight.bold),
        ),
        const Text('Room Number', style: roomNumberTextStyle),
      ],
    );
  }

  Widget _floor(String number) {
    const TextStyle floorNumberTextStyle =
        TextStyle(color: AppColors.darkPrimaryColor, fontSize: 16);
    return Column(
      children: [
        Text(
          number.toString(),
          style: floorNumberTextStyle.copyWith(
              fontSize: 53, fontWeight: FontWeight.bold),
        ),
        const Text('Floor', style: floorNumberTextStyle),
      ],
    );
  }

  Widget _assignedTo() {
    if (assignedTo != null) {
      return Text(
        'Assigned to $assignedTo',
        style: const TextStyle(fontSize: 16),
      );
    }
    return Container();
  }
}

class _OrderDetailsItems extends StatelessWidget {
  const _OrderDetailsItems({Key? key, required this.orderDetails})
      : super(key: key);
  final List<OrderDetailModel> orderDetails;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Details',
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: orderDetails.length,
          itemBuilder: (_, index) =>
              _OrderDetailItem(details: orderDetails[index]),
        ),
      ],
    );
  }
}

class _OrderDetailItem extends StatelessWidget {
  const _OrderDetailItem({Key? key, required this.details}) : super(key: key);
  final OrderDetailModel details;
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);

    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          details.service,
          style: textStyle,
        ),
      ],
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({Key? key, required this.price}) : super(key: key);
  final double price;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.blue1, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Price',
              style: TextStyle(fontSize: 14, color: AppColors.darkPrimaryColor),
            ),
            Center(
              child: Text(
                '${price.toString()} \$',
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 39,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChangeAssignmentButton extends StatelessWidget {
  const _ChangeAssignmentButton({Key? key, required this.taskStatus})
      : super(key: key);
  final Task taskStatus;
  @override
  Widget build(BuildContext context) {
    if (taskStatus is FinishedTask) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: DefaultButton(
        text: taskStatus.getText(),
        // _getText(),
        radius: 6,
        onPressed: () {},
      ),
    );
  }

  String _getText() {
    if (taskStatus is ActiveTask) {
      return 'Start task';
    } else if (taskStatus is PendingTask) {
      return 'End task';
    } else {
      return '';
    }
  }
}

class _OrderDetailsActionButton extends StatelessWidget {
  const _OrderDetailsActionButton(
      {Key? key,
      required this.taskStatus,
      required this.order,
      required this.homeCubit,
      required this.onPressed})
      : super(key: key);
  final Task taskStatus;
  final OrderModel order;
  final HomeCubit homeCubit;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    log(taskStatus.toString());
    if (taskStatus is FinishedTask) return Container();
    if (taskStatus is PendingSupervisorTask) {
      return Row(
        children: [
          Expanded(flex: 4, child: _defaultButton(context)),
          Expanded(child: Container()),
          Expanded(flex: 4, child: _endButton(context))
        ],
      );
    }
    return _defaultButton(context);
  }

  Widget _defaultButton(context) {
    return DefaultButton(
      text: taskStatus.getText(),
      radius: 6,
      onPressed: () {
        homeCubit.onStatusTapped(context, taskStatus, order);
      },
    );
  }

  Widget _endButton(context) {
    return DefaultButton(
      text: 'Change assignment',
      radius: 6,
      onPressed: () async {
        await SupervisorOrderDetailsCubit.instance(context)
            .changeAssignedEmployee(context, order);
      },
    );
  }
}
