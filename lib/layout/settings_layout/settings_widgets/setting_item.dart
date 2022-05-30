import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/svg_image_widget.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    this.imagePath,
    this.trailing,
    this.onTap,
    required this.text,
  }) : super(key: key);
  final String text;
  final String? imagePath;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        leading: imagePath != null
            ? SvgImageWidget(
                path: imagePath!,
                width: 18,
                height: 18,
                color: Colors.white,
              )
            : const FittedBox(
                child: Text(' '),
              ),
        trailing: trailing,
      ),
    );
  }
}
