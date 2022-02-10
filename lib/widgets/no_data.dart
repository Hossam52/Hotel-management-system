import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Icon(Icons.error, color: AppColors.blue1),
          Center(child: Text('No data', style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
