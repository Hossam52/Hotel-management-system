import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:htask/models/tab_bar_model.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/error_widget.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/services_toaday.dart';
import 'package:htask/widgets/svg_image_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: HomeCubit.instance(context).activeScrollController,
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(padding),
                child: SizedBox(
                    height: height * 0.13,
                    child: BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                      if (state is ErrorAllCategoriesHomeState) {
                        showErrorToast(state.error);
                      }
                    }, builder: (context, state) {
                      if (state is LoadingAllCategoriesHomeState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.darkPrimaryColor,
                        ));
                      }
                      return const ServiceToday();
                    })),
              ),
              const Padding(
                padding: EdgeInsets.all(padding),
                child: HomeTabsStatuses(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTabsStatuses extends StatelessWidget {
  const HomeTabsStatuses({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ErrorAllOrdersHomeState) showErrorToast(state.error);
      },
      builder: (context, state) {
        if (state is ErrorAllOrdersHomeState) {
          return DefaultErrorWidget(refreshMethod: () {
            HomeCubit.instance(context).getAllOrders(context);
          });
        }
        if (state is LoadingAllOrdersHomeState ||
            state is LoadingAllCategoriesHomeState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final cubit = HomeCubit.instance(context);
        final tabBars = cubit.tabBars;
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.selectedColor.withOpacity(0.38),
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < tabBars.length; i++)
                      FittedBox(
                        child: GestureDetector(
                          onTap: () => cubit.changeTabIndex(i),
                          child: _buildTapContent(tabBars[i]),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      tabBars[cubit.selectedTabIndex].widget,
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is LoadingNextAllOrdersHomeState) {
                            return const Center(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ));
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  Widget _buildTapContent(TabBarItem tab) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: tab.isSelected ? AppColors.white : null,
          borderRadius: tab.isSelected ? BorderRadius.circular(30) : null),
      child: Row(
        children: [
          if (tab.isSelected)
            Row(
              children: [
                SvgImageWidget(
                  path: tab.imagePath,
                  width: 23,
                  height: 23,
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          Text(
            tab.text.tr(),
            style: const TextStyle(
                fontSize: 18, color: AppColors.darkPrimaryColor),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
