import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/layout/settings_layout/settings_widgets/hotel_info.dart';
import 'package:htask/layout/more/settings_widgets/setting_item.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/home_header.dart';

class EmployeeSettingsScreen extends StatelessWidget {
  const EmployeeSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingsLayout(
      trailing: totalCach(context),
    );
  }

  Widget totalCach(BuildContext context) {
    final profile = AppCubit.instance(context).getProfile;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heading(),
            moneyAmount(1200, currency: profile.currency),
          ],
        ),
      ),
    );
  }

  Widget heading() {
    return Row(children: const [
      SizedBox(width: 10),
      Text(
        'Total cach money you have',
        style: TextStyle(fontSize: 19),
      ),
    ]);
  }

  Widget moneyAmount(int number, {String currency = ''}) {
    const TextStyle textStyle =
        TextStyle(color: AppColors.darkPrimaryColor, fontSize: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            number.toString(),
            style:
                textStyle.copyWith(fontSize: 80, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          currency,
          style: textStyle,
        ),
      ],
    );
  }
}

class SupervisorSettingsScreen extends StatelessWidget {
  const SupervisorSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _SettingsLayout();
  }
}

//------------------------------------------------------------
class _SettingsLayout extends StatelessWidget {
  const _SettingsLayout({Key? key, this.trailing}) : super(key: key);
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Builder(builder: (context) {
        return BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) => current is ChangeAppLanguage,
          builder: (context, state) {
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoadingLogoutState) log('Loading logout state');
                if (state is SuccessLogoutState) {
                  showSuccessToast(state.message);
                }
                if (state is ErrorLogoutState) showErrorToast(state.error);
              },
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      const HomeHeader(),
                      const HotelInfo(),
                      if (trailing != null) trailing!,
                      SettingItem(
                          text: 'ReportProblem'.tr(),
                          imagePath: 'assets/images/icons/report.svg'),
                      _languageWidget(),
                      SettingItem(
                          text: 'Logout'.tr(),
                          imagePath: 'assets/images/icons/logout.svg',
                          onTap: () async {
                            await AuthCubit.instance(context).logout(context);
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  BlocBuilder<AppCubit, AppState> _languageWidget() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => current is ChangeAppLanguage,
      builder: (context, state) {
        return SettingItem(
            text: 'Language'.tr(),
            imagePath: 'assets/images/icons/language.svg',
            trailing: Text(
              AppCubit.instance(context).language.getString,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (_) => const _ChangeLanguageDialog());
            });
      },
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
              _languageRow(context, const Locale('ar', 'EG'), Language.arabic),
              const SizedBox(height: 10),
              _languageRow(context, const Locale('en', 'US'), Language.english),
            ],
          ),
        );
      },
    );
  }

  Widget _languageRow(
      BuildContext context, Locale locale, Language displayedLanguage) {
    return GestureDetector(
      onTap: () {
        AppCubit.instance(context).changeLanguage(context, locale);
        Navigator.pop(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }
}
