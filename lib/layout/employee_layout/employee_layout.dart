import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/employee_layout/cubit/employee_cubit.dart';
import 'package:htask/layout/employee_layout/cubit/employee_states.dart';
import 'package:htask/layout/widgets/selected_filtered_date.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/home/home.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/more/more_screen.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/bottom_navigation.dart';
import 'package:htask/widgets/error_widget.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/svg_image_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EmployeeLayout extends StatelessWidget {
  const EmployeeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getAllOrders(context),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => EmployeeCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: BlocBuilder<EmployeeCubit, EmployeeStates>(
        builder: (context, state) {
          final cubit = EmployeeCubit.instance(context);
          return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(
                curve: Curves.bounceInOut,
                selectedColorOpacity: 0.2,
                onTap: (index) {
                  cubit.changeSelectedTabIndex(index);
                },
                currentIndex: cubit.selectedTabIndex,
                items: [
                  _builNavItem(
                      'assets/images/icons/home_bottom_tab.svg', 'Home'),
                  _builNavItem(
                      'assets/images/icons/notification_bottom_tab.svg',
                      'Notification'),
                  _builNavItem(
                      'assets/images/icons/more_bottom_tab.svg', 'More'),
                ],
              ),
              body: cubit.getScreen());
        },
      ),
    );
  }

  CustomBottomNavBarItem _builNavItem(String iconPath, String title) {
    return CustomBottomNavBarItem(
        selectedColor: AppColors.darkPrimaryColor,
        icon: SvgImageWidget(
          path: iconPath,
          color: AppColors.darkPrimaryColor,
        ),
        // Image.asset(
        //   iconPath,
        //   scale: 1.3,
        // ),
        title: Text(title));
  }
}

class HomeEmployee extends StatelessWidget {
  const HomeEmployee({Key? key}) : super(key: key);

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
                    HomeHeader(showFilterByDate: true),
                    SelectedFilteredDate(),
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
