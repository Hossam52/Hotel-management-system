import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:htask/models/tab_bar_model.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/default_circular_progress.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/services_toaday.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..getAllOrders(context),
        lazy: false,
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingAllOrdersHomeState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.darkPrimaryColor,
              ));
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: SizedBox(
                          height: height * 0.13, child: const ServiceToday()),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(padding),
                      child: _HomeTabsStatuses(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HomeTabsStatuses extends StatelessWidget {
  const _HomeTabsStatuses({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.instance(context);
    final tabBars = cubit.tabBars;
    final activeOrders = cubit.getActiveOrders();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.selectedColor.withOpacity(0.38),
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(8),
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
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: tabBars[cubit.selectedTabIndex].widget,
                )),
            // ListView.builder(
            //     primary: true,
            //     shrinkWrap: true,
            //     itemCount: activeOrders.length,
            //     itemBuilder: (_, index) {
            //       return tabBars[index].widget;
            //     }),
            // TabBar(
            //   isScrollable: true,
            //   padding: const EdgeInsets.all(0),
            //   tabs: tabBars.map((tap) => _buildTapContent(tap)).toList(),
            //   indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
            //   onTap: cubit.changeTabIndex,
            // ),
            const SizedBox(height: 30),
          ],
        );
      },
    );

    return DefaultTabController(
      length: tabBars.length,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.selectedColor.withOpacity(0.38),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(8),
            child: TabBar(
              isScrollable: true,
              padding: const EdgeInsets.all(0),
              tabs: tabBars.map((tap) => _buildTapContent(tap)).toList(),
              indicator:
                  const UnderlineTabIndicator(borderSide: BorderSide.none),
              onTap: cubit.changeTabIndex,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
              height: 1000,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(8),
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: tabBars.map((e) => e.widget).toList())))
        ],
      ),
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
                Image.asset(tab.imagePath, scale: 1.3),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          Text(
            tab.text,
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
