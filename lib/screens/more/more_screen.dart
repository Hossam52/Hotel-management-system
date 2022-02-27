import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/custom_switch.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/svg_image_widget.dart';

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
                // _buildItem('Available',
                //     trailing: CustomSwitch(
                //       val: false,
                //       onToggle: (val) {},
                //     )),
                _buildItem('Report problem',
                    imagePath: 'assets/images/icons/report.svg'),
                _buildItem('Logout',
                    imagePath: 'assets/images/icons/logout.svg',
                    onTap: () async {
                  await AuthCubit.instance(context).logout(context);
                }),
                BlocBuilder<AppCubit, AppState>(
                  buildWhen: (previous, current) =>
                      current is ChangeAppLanguage,
                  builder: (context, state) {
                    return _buildItem('Language',
                        imagePath: 'assets/images/icons/language.svg',
                        trailing: Text(
                          AppCubit.instance(context).language.getString,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ), onTap: () async {
                      showDialog(
                          context: context,
                          builder: (_) => _ChangeLanguageDialog());
                    });
                  },
                ),
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
            ? SvgImageWidget(
                path: imagePath,
                width: 18,
                height: 18,
                color: Colors.white,
              )
            : const FittedBox(
                child: Text(' '),
              ),
        trailing: trailing,
      ),
    );
  }
}

class _ChangeLanguageDialog extends StatelessWidget {
  const _ChangeLanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageRow(context, Language.arabic),
              _languageRow(context, Language.english),
            ],
          ),
        );
      },
    );
  }

  Widget _languageRow(BuildContext context, Language displayedLanguage) {
    return GestureDetector(
      onTap: () {
        AppCubit.instance(context).changeLanguage(displayedLanguage);
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: displayedLanguage == AppCubit.instance(context).language
                  ? const Icon(Icons.done, size: 25)
                  : Container(),
            ),
            Expanded(
              flex: 5,
              child: Text(
                displayedLanguage.getString,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
