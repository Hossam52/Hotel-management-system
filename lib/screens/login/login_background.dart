import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            gradient: LinearGradient(
              colors: [
                Color(0xff1F67A6),
                AppColors.primaryColor,
                AppColors.primaryColor,
                AppColors.primaryColor,
                AppColors.primaryColor,
                AppColors.primaryColor,
                Color(0xff1F67A6),
              ],
            ),
          ),
        ),
        _circleOnStack(Color(0xaf277ECB),
            left: -width * 0.34, bottom: height * 0.2),
        _circleOnStack(Color(0xaf2D95F1),
            left: -width * 0.2, top: -height * 0.05),
        _circleOnStack(Color(0xaf2C8DE3),
            right: -width * 0.35, top: height * 0.18),
        // _circleOnStack(Color(0xaf277ECB), left: -130, bottom: 160),
        // _circleOnStack(Color(0xaf2D95F1), left: -70, top: -40),
        // _circleOnStack(Color(0xaf2C8DE3), right: -131, top: 140),
      ],
    );
  }

  Positioned _circleOnStack(Color backgroundColor,
      {double? top, double? left, double? right, double? bottom}) {
    return Positioned(
      width: 300,
      child: FittedBox(
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 300,
        ),
      ),
      top: top,
      bottom: bottom,
      right: right,
      left: left,
    );
  }
}
