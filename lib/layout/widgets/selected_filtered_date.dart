import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:time_range_picker/time_range_picker.dart';

class SelectedFilteredDate extends StatelessWidget {
  const SelectedFilteredDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 17, color: AppColors.white);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (_, newState) => newState is ChangeDateFilterState,
      builder: (context, state) {
        final date = HomeCubit.instance(context).filterByDate;
        final time = HomeCubit.instance(context).filterByTime;
        if (date == null && time == null) return Container();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filteredDate(date, textStyle),
                    const SizedBox(height: 10),
                    _filteredTime(time, textStyle)
                  ],
                ),
              ),

              Expanded(
                  child: FittedBox(child: _searchButton(context, textStyle))),
              // TextButton(onPressed: () {}, child: Text('Change')),
            ],
          ),
        );
      },
    );
  }

  Widget _searchButton(BuildContext context, TextStyle textStyle) {
    return TextButton(
      onPressed: () async {
        log('HELLO');
        await HomeCubit.instance(context).getOrdersPerType(context);
      },
      child: Text(
        'Search'.tr(),
        style: textStyle,
      ),
    );
  }

  Widget _headerText(String header, TextStyle style) {
    return Text(
      header,
      style: style.copyWith(color: Colors.black),
    );
  }

  Widget _filteredDate(DateTime? date, TextStyle textStyle) {
    if (date == null) {
      return Container();
    }
    return Row(
      children: [
        _headerText(
          'FilteredDateIs'.tr() + ' : ',
          textStyle,
        ),
        const _FilteredDate(),
      ],
    );
  }

  Widget _filteredTime(TimeRange? timeRange, TextStyle textStyle) {
    if (timeRange == null) return Container();
    return Column(
      children: [
        Row(
          children: [
            _headerText(
              'From : ',
              textStyle,
            ),
            _FilteredTime(time: timeRange.startTime),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _headerText(
              'To : ',
              textStyle,
            ),
            _FilteredTime(time: timeRange.endTime),
          ],
        ),
      ],
    );
  }
}

class _ColoredContainer extends StatelessWidget {
  const _ColoredContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.darkPrimaryColor.withOpacity(0.4),
        ),
        child: child);
  }
}

class _FilteredDate extends StatelessWidget {
  const _FilteredDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 17, color: AppColors.white);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final date = HomeCubit.instance(context).filterByDate;
        if (date == null) {
          return Container();
        }
        final dateString = formatDateWithoutTime(date);
        return _ColoredContainer(
          child: Row(
            children: [
              Text(
                dateString,
                style: textStyle,
              ),
              InkWell(
                onTap: () {
                  HomeCubit.instance(context).changeFilterDate(null);
                  HomeCubit.instance(context).getOrdersPerType(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.cancel, color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _FilteredTime extends StatelessWidget {
  const _FilteredTime({Key? key, required this.time}) : super(key: key);
  final TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 17, color: AppColors.white);
    final timeString = '${time.hour}:${time.minute}';
    return _ColoredContainer(
      child: Row(
        children: [
          Text(
            timeString,
            style: textStyle,
          ),
          InkWell(
            onTap: () {
              HomeCubit.instance(context).changeFilterTimeRange(null);
              HomeCubit.instance(context).getOrdersPerType(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.cancel, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
