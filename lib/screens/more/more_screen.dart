import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/custom_switch.dart';
import 'package:htask/widgets/default_cached_image.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/svg_image_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

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
                if (state is SuccessLogoutState)
                  showSuccessToast(state.message);
                if (state is ErrorLogoutState) showErrorToast(state.error);
              },
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      const HomeHeader(),
                      // _buildItem('Available',
                      //     trailing: CustomSwitch(
                      //       val: false,
                      //       onToggle: (val) {},
                      //     )),
                      const _HotelInfo(),
                      _buildItem('ReportProblem'.tr(),
                          imagePath: 'assets/images/icons/report.svg'),

                      BlocBuilder<AppCubit, AppState>(
                        buildWhen: (previous, current) =>
                            current is ChangeAppLanguage,
                        builder: (context, state) {
                          return _buildItem('Language'.tr(),
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
                      _buildItem('Logout'.tr(),
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

class _HotelInfo extends StatelessWidget {
  const _HotelInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = AppCubit.instance(context).getProfile;
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: profile.hotel_logo,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.18,
        ),
        Text(
          profile.hotel,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
