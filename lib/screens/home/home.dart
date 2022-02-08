import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:htask/models/tab_bar_model.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/styles/colors.dart';
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
        child: SafeArea(
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
        ),
      ),
    );
  }
}

class _HomeTabsStatuses extends StatefulWidget {
  const _HomeTabsStatuses({Key? key}) : super(key: key);

  @override
  State<_HomeTabsStatuses> createState() => _HomeTabsStatusesState();
}

class _HomeTabsStatusesState extends State<_HomeTabsStatuses> {
  @override
  Widget build(BuildContext context) {
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
              onTap: onTapPressed,
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

  void onTapPressed(index) {
    setState(() {
      for (int i = 0; i < tabBars.length; i++) {
        tabBars[i].isSelected = false;
      }
      tabBars[index].isSelected = true;
    });
  }
}
