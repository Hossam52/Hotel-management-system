import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/supervisor_layout/cubit/supervisor_cubit.dart';
import 'package:htask/layout/supervisor_layout/cubit/supervisor_states.dart';
import 'package:htask/layout/widgets/selected_filtered_date.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/home/home.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/more/more_screen.dart';
import 'package:htask/screens/staff/cubit/staff_cubit.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/bottom_navigation.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/services_toaday.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SuperVisorHomeLayout extends StatelessWidget {
  const SuperVisorHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Hello from supervisor layout');
    return MultiBlocProvider(
      providers: [
        BlocProvider<SupervisorCubit>(
            create: (context) => SupervisorCubit(), lazy: false),
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()..getAllCategories(context),
            lazy: false),
        BlocProvider<StaffCubit>(
          create: (context) => StaffCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: BlocBuilder<SupervisorCubit, SupervisorStates>(
        builder: (context, state) {
          final cubit = SupervisorCubit.instance(context);
          return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(
                curve: Curves.bounceInOut,
                selectedColorOpacity: 0.2,
                onTap: (index) {
                  cubit.changeSelectedTabIndex(index);
                },
                currentIndex: cubit.selectedTabIndex,
                items: [
                  _builNavItem('assets/images/home.png', 'Home'),
                  _builNavItem('assets/images/staff.png', 'Staff'),
                  _builNavItem('assets/images/more.png', 'More'),
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
        icon: Image.asset(
          iconPath,
          scale: 1.3,
        ),
        title: Text(title));
  }
}

class SupervisorHome extends StatelessWidget {
  const SupervisorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is ErrorAllCategoriesHomeState) showErrorToast(state.error);
        },
        builder: (context, state) {
          if (state is LoadingAllCategoriesHomeState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.darkPrimaryColor,
            ));
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HomeHeader(
                    showFilterByDate: true,
                  ),
                  const SelectedFilteredDate(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: SizedBox(
                        height: height * 0.13, child: const ServiceToday()),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(padding),
                    child: HomeTabsStatuses(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
