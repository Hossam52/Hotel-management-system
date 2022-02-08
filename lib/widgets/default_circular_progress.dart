import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultCircularProgress extends StatelessWidget {
  const DefaultCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text(
          'Loading ...',
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
        CircularProgressIndicator(
          color: AppColors.lightPrimary,
        ),
      ],
    );
  }
}
