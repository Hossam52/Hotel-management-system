import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/styles/colors.dart';

class HotelInfo extends StatelessWidget {
  const HotelInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = AppCubit.instance(context).getProfile;
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: profile.hotel_logo,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.18,
        ),
        Text(
          profile.hotel,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
