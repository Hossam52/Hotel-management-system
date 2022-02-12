import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/default_cached_image.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    this.showFilterByDate = false,
  }) : super(key: key);
  final bool showFilterByDate;
  @override
  Widget build(BuildContext context) {
    final profile = AppCubit.instance(context).getProfile;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.blue1,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          DefaultCachedImage(imagePath: profile.image),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello, ${profile.name}',
                style: AppTextStyles.textStyle1,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Have a greate working day',
                style: AppTextStyles.textStyle2,
              ),
            ],
          ),
          const Spacer(),
          if (showFilterByDate) _filterWidget(context),
        ],
      ),
    );
  }

  Widget _filterWidget(context) {
    return IconButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 90)),
            lastDate: DateTime.now());
        if (selectedDate != null) {
          HomeCubit.instance(context).changeFilterDate(selectedDate);
        }
      },
      icon: const Icon(Icons.date_range),
      color: AppColors.white,
    );
  }
}
