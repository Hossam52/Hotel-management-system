import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';

class SelectedFilteredDate extends StatelessWidget {
  const SelectedFilteredDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 17, color: AppColors.white);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (_, newState) => newState is ChangeDateFilterState,
      builder: (context, state) {
        final date = HomeCubit.instance(context).filterByDate;
        if (date == null) {
          return Container();
        }
        final dateString = formatDateWithoutTime(date);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Filtered date is: ',
                style: textStyle.copyWith(color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.darkPrimaryColor.withOpacity(0.4),
                ),
                child: Row(
                  children: [
                    Text(
                      dateString,
                      style: textStyle,
                    ),
                    InkWell(
                      onTap: () {
                        HomeCubit.instance(context).changeFilterDate(null);
                        HomeCubit.instance(context).getAllOrders(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.cancel, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  await HomeCubit.instance(context).getAllOrders(context);
                },
                child: Text(
                  'Search',
                  style: textStyle,
                ),
              )
              // TextButton(onPressed: () {}, child: Text('Change')),
            ],
          ),
        );
      },
    );
  }
}
