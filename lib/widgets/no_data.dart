import 'package:easy_localization/easy_localization.dart';
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
        children:  [
          Icon(Icons.error, color: AppColors.blue1),
          Center(child: Text('NoData'.tr(), style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
