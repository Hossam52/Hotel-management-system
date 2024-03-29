import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/default_cached_image.dart';
import 'package:time_range_picker/time_range_picker.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    this.showFilterByDate = false,
  }) : super(key: key);
  final bool showFilterByDate;
  @override
  Widget build(BuildContext context) {
    final profile = AppCubit.instance(context).getProfile;
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: ((previous, current) => current is ChangeAppLanguage),
      builder: (context, state) {
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
                    '${"Hello".tr()}, ${profile.name}',
                    style: AppTextStyles.textStyle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'HaveGreateWorkingDay'.tr(),
                    style: AppTextStyles.textStyle2,
                  ),
                ],
              ),
              const Spacer(),
              if (showFilterByDate) Expanded(child: _filterWidget(context)),
            ],
          ),
        );
      },
    );
  }

  Widget _filterWidget(context) {
    return GestureDetector(
      child: Icon(Icons.filter_alt_rounded, color: AppColors.white),
      onTap: () {
        _onDateTapped(context);
      },
    );
    return PopupMenuButton<String>(
      onSelected: (value) async {
        log(value.toString());
        if (value == 'date') {
          _onDateTapped(context);
        } else if (value == 'time') {
          _onTimeTapped(context);
        }
      },
      icon: const Icon(Icons.filter_alt_rounded, color: AppColors.white),
      itemBuilder: (_) => [
        _filterItem(icon: Icons.date_range, title: 'Date', value: 'date'),
        _filterItem(
            icon: Icons.access_time_sharp, title: 'Time', value: 'time'),
      ],
    );

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

  void _onDateTapped(BuildContext context) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 90)),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      HomeCubit.instance(context).changeFilterDate(selectedDate);
    }
  }

  void _onTimeTapped(BuildContext context) async {
    TimeRange? result = await showTimeRangePicker(
      context: context,
      interval: const Duration(minutes: 30),
      ticks: 12,
      ticksColor: AppColors.darkPrimaryColor,
      ticksWidth: 2,
    );
    if (result != null) {
      HomeCubit.instance(context).changeFilterTimeRange(result);
    }
  }

  PopupMenuItem<String> _filterItem(
      {required IconData icon, required String title, required String value}) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(icon, color: AppColors.blue1),
          Text(
            title,
            style: AppTextStyles.textStyle2.copyWith(color: AppColors.blue1),
          ),
        ],
      ),
      value: value,
    );
  }
}
