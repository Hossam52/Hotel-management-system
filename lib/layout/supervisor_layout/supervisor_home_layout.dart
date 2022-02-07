import 'package:flutter/material.dart';
import 'package:htask/screens/home/home.dart';
import 'package:htask/screens/more/more_screen.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SuperVisorHomeLayout extends StatelessWidget {
  const SuperVisorHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: const [
        HomeScreen(),
        StaffScreen(),
        MoreScreen(),
      ],
      confineInSafeArea: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.green,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      items: [
        _builNavItem('assets/images/home.png', 'Home'),
        _builNavItem('assets/images/staff.png', 'Staff'),
        _builNavItem('assets/images/more.png', 'More'),
      ],
      navBarStyle: NavBarStyle.style7,
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
