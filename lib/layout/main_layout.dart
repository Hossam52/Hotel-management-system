import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/home/home.dart';
import 'package:htask/screens/more/more_screen.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/error_widget.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainHomeLayout extends StatelessWidget {
  const MainHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getAllOrders(context),
      lazy: false,
      child: PersistentTabView(
        context,
        screens: const [
          _HomeEmployee(),
          MoreScreen(),
        ],
        confineInSafeArea: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.green,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          // colorBehindNavBar: AppColors.
        ),
        items: [
          _builNavItem('assets/images/home.png', 'Home'),
          _builNavItem('assets/images/more.png', 'More'),
        ],
        navBarStyle: NavBarStyle.style7,
      ),
    );
  }

  PersistentBottomNavBarItem _builNavItem(String iconPath, String title) {
    return PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.lightPrimary,
        activeColorSecondary: AppColors.darkPrimaryColor,
        icon: Image.asset(
          iconPath,
          scale: 1.3,
        ),
        title: title);
  }
}

class _HomeEmployee extends StatelessWidget {
  const _HomeEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
        backgroundColor: AppColors.lightPrimary,
        body: SafeArea(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is ErrorAllOrdersHomeState) {
                log(state.error);
                showErrorToast(state.error);
              }
              if (state is ErrorAllCategoriesHomeState) {
                showErrorToast(state.error);
              }
            },
            builder: (_, state) {
              if (state is LoadingAllOrdersHomeState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorAllOrdersHomeState) {
                return DefaultErrorWidget(
                    refreshMethod: () =>
                        HomeCubit.instance(context).getAllOrders(context));
              }
              return SingleChildScrollView(
                child: Column(
                  children: const [
                    HomeHeader(),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: HomeTabsStatuses(),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
