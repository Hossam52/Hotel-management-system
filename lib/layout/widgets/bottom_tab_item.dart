import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/svg_image_widget.dart';

class BottomTabItem extends StatelessWidget {
  const BottomTabItem({Key? key, required this.iconPath}) : super(key: key);
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return SvgImageWidget(
      path: iconPath,
      color: AppColors.darkPrimaryColor,
    );
  }
}
