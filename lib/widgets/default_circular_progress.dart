import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultCircularProgress extends StatelessWidget {
  const DefaultCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:  [
        Text(
          'Loading'.tr(),
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
        CircularProgressIndicator(
          color: AppColors.lightPrimary,
        ),
      ],
    );
  }
}
