import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

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
        child: ListView.separated(
          itemBuilder: (_, index) {
            return const _NotificationItem();
          },
          itemCount: 10,
          separatorBuilder: (_, index) {
            return const SizedBox(height: 10);
          },
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Notification title',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              'This is description this is descriptionThis is description this is description',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
