import 'package:flutter/material.dart';
import 'package:htask/models/tasks.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/defulat_button.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.taskStatus}) : super(key: key);
  final Task taskStatus;
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Time(taskStatus: taskStatus),
              const _PersonalDataStatistics(
                assignedTo: 'Mohamed medhat',
              ),
              const SizedBox(height: 30),
              const _OrderDetailsItems(),
              const SizedBox(height: 30),
              const _Price(price: 120),
              const SizedBox(height: 30),
              _ChangeAssignmentButton(
                taskStatus: taskStatus,
              )
            ],
          ),
        ),
      ),
    );
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
    if (taskStatus is BeginTask) {
      return 'Estimated time';
    } else if (taskStatus is EndTask) {
      return 'Remaining estimated';
    }
    return '';
  }
}

class _PersonalDataStatistics extends StatelessWidget {
  const _PersonalDataStatistics({Key? key, this.assignedTo}) : super(key: key);
  final String? assignedTo;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _roomNumber(11),
                _floor(2),
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
        text: const TextSpan(
            text: 'Mr ',
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(text: 'Ahmed mohamed', style: TextStyle(fontSize: 19)),
            ]),
      )
    ]);
  }

  Widget _roomNumber(int number) {
    const TextStyle roomNumberTextStyle =
        TextStyle(color: AppColors.darkPrimaryColor, fontSize: 16);
    return Column(
      children: [
        Text(
          number.toString(),
          style: roomNumberTextStyle.copyWith(
              fontSize: 100, fontWeight: FontWeight.bold),
        ),
        const Text('Room Number', style: roomNumberTextStyle),
      ],
    );
  }

  Widget _floor(int number) {
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
  const _OrderDetailsItems({Key? key}) : super(key: key);
  final List<String> items = const [
    'Washing clothes',
    '3 pieces',
    'Needed as soon as possible plz'
  ];
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Details',
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: items
              .map(
                (e) => Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      e,
                      style: textStyle,
                    ),
                  ],
                ),
              )
              .toList(),
        )
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
        text: _getText(),
        radius: 6,
        onPressed: () {},
      ),
    );
  }

  String _getText() {
    if (taskStatus is BeginTask) {
      return 'Start task';
    } else if (taskStatus is EndTask) {
      return 'End task';
    } else {
      return '';
    }
  }
}
