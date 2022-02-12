import 'package:flutter/material.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/default_cached_image.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

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
          )
        ],
      ),
    );
  }
}
