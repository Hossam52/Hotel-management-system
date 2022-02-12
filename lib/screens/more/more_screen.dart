import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/custom_switch.dart';
import 'package:htask/widgets/home_header.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Builder(builder: (context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingLogoutState) log('Loading logout state');
            if (state is SuccessLogoutState) showSuccessToast(state.message);
            if (state is ErrorLogoutState) showErrorToast(state.error);
          },
          child: SafeArea(
            child: Column(
              children: [
                const HomeHeader(),
                _buildItem('Available',
                    trailing: CustomSwitch(
                      val: false,
                      onToggle: (val) {},
                    )),
                _buildItem('Report problem',
                    imagePath: 'assets/images/report.png'),
                _buildItem('Logout', imagePath: 'assets/images/logout.png',
                    onTap: () async {
                  await AuthCubit.instance(context).logout(context);
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildItem(String text,
      {String? imagePath, Widget? trailing, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white),
        ),
        leading: imagePath != null
            ? Image.asset(imagePath)
            : const FittedBox(
                child: Text(' '),
              ),
        trailing: trailing,
      ),
    );
  }
}
