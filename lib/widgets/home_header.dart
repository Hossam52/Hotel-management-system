import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.blue1,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/pseronal_image.png'),
            radius: 40,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Hello, Ahmed',
                style: AppTextStyles.textStyle1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
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
