import 'package:flutter/material.dart';
import 'package:htask/screens/home/widgets/status_item.dart';

class ActiveWidget extends StatelessWidget {
  const ActiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => const SizedBox(height: 15),
      itemCount: 14,
      itemBuilder: (_, index) => const StatusItem(
        statusImagePath: 'assets/images/timer.png',
      ),
    );
  }
}

class PendingWidget extends StatelessWidget {
  const PendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => const SizedBox(height: 15),
      itemCount: 14,
      itemBuilder: (_, index) => const StatusItem(
        statusImagePath: 'assets/images/waiting.png',
      ),
    );
  }
}

class FinishedWidget extends StatelessWidget {
  const FinishedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => const SizedBox(height: 15),
      itemCount: 14,
      itemBuilder: (_, index) => const StatusItem(
        statusImagePath: 'assets/images/completed.png',
      ),
    );
  }
}
