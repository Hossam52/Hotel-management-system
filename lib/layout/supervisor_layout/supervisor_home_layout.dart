import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/layout/supervisor_layout/cubit/supervisor_cubit.dart';
import 'package:htask/layout/supervisor_layout/cubit/supervisor_states.dart';
import 'package:htask/layout/widgets/bottom_tab_item.dart';
import 'package:htask/layout/widgets/notification_widget.dart';
import 'package:htask/layout/widgets/selected_filtered_date.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/home/home.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/more/more_screen.dart';
import 'package:htask/screens/notifications/cubit/notification_cubit.dart';
import 'package:htask/screens/staff/cubit/staff_cubit.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/bottom_navigation.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/services_toaday.dart';
import 'package:htask/widgets/svg_image_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

//Y-m-d G:i:s
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
            create: (context) => HomeCubit(context)..getAllCategories(context),
            lazy: false),
        BlocProvider<StaffCubit>(
          create: (context) => StaffCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) =>
              NotificationCubit(context)..getAllNotifications(context),
          lazy: false,
        ),
      ],
      child: BlocListener<AppCubit, AppState>(
        listenWhen: (previous, current) => current is CloseNotificationScreen,
        listener: (context, state) {
          if (state is CloseNotificationScreen) {
            HomeCubit.instance(context).getOrdersPerType(context);
          }
        },
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
                    _buildNavItem(
                        const BottomTabItem(
                            iconPath:
                                'assets/images/icons/home_bottom_tab.svg'),
                        'Home'),
                    _buildNavItem(
                        const BottomTabItem(
                            iconPath:
                                'assets/images/icons/staff_bottom_tab.svg'),
                        'Staff'),
                    _buildNavItem(
                        const BottomTabItem(
                            iconPath: 'assets/images/icons/dashboard.svg'),
                        'Dashboard'),
                    _buildNavItem(const NotificationWidget(), 'Notification'),
                    _buildNavItem(
                        const BottomTabItem(
                            iconPath:
                                'assets/images/icons/more_bottom_tab.svg'),
                        'More'),
                  ],
                ),
                body: cubit.getScreen());
          },
        ),
      ),
    );
  }

  CustomBottomNavBarItem _buildNavItem(Widget icon, String title) {
    return CustomBottomNavBarItem(
        selectedColor: AppColors.darkPrimaryColor,
        icon: icon,
        title: Text(title));
  }
}

class SupervisorHome extends StatelessWidget {
  const SupervisorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log(HomeCubit.instance(context).allOrders.newStatus.data.length.toString());
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is ErrorAllCategoriesHomeState) showErrorToast(state.error);
        },
        builder: (context, state) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await HomeCubit.instance(context).getAllCategories(context);
                await HomeCubit.instance(context).getOrdersPerType(context);
              },
              child: SingleChildScrollView(
                controller: HomeCubit.instance(context).homeScrollController,
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
            ),
          );
        },
      ),
    );
  }
}
