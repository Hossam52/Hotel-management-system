import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget(
      {Key? key, required this.refreshMethod, this.textColor = Colors.white})
      : super(key: key);
  final VoidCallback refreshMethod;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: AppColors.darkPrimaryColor,
          ),
          const SizedBox(height: 20),
          Text('ErrorHappened'.tr()),
          const SizedBox(height: 20),
          TextButton(
            onPressed: refreshMethod,
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(textColor)),
            child: Text(
              'Refreshnow'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
