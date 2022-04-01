import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/screens/login/login_widgets/auth_type_widget.dart';
import 'package:htask/shared/responsive/responsive.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/default_text_field.dart';
import 'package:htask/widgets/defulat_button.dart';
import 'package:htask/widgets/svg_image_widget.dart';

class AuthFieldsResponsive extends StatelessWidget {
  const AuthFieldsResponsive({Key? key}) : super(key: key);
  Widget getEmailField(AuthCubit authCubit) => DefaultTextField(
        hintText: 'Email'.tr(),
        isPassword: false,
        controller: authCubit.loginEmailController,
        validator: authCubit.validateEmail,
      );
  Widget getPasswordField(AuthCubit authCubit) => DefaultTextField(
        hintText: 'Password'.tr(),
        passwordWidget: _passwordWidget(authCubit),
        isPassword: authCubit.visiblePassword,
        controller: authCubit.loginPasswordController,
        validator: authCubit.validatePassword,
      );
  Widget getHotelCode(AuthCubit authCubit) => DefaultTextField(
        hintText: 'Hotel_Code'.tr(),
        isPassword: false,
        controller: authCubit.loginHotelCodeController,
        validator: authCubit.validateHotelCode,
      );
  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.instance(context);
    return ResponsiveLayoutWidget(
      smallChild: _smallLayout(authCubit),
      mediumChild: _mediumLayout(authCubit),
    );
  }

  Widget _mediumLayout(AuthCubit authCubit) {
    return Builder(builder: (context) {
      final width = MediaQuery.of(context).size.width;

      return Container(
        constraints: BoxConstraints(
          maxWidth: width * (7 / 6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: getEmailField(authCubit)),
                  const SizedBox(width: 10),
                  Expanded(child: getPasswordField(authCubit)),
                ],
              ),
              getHotelCode(authCubit),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.lightPrimary.withAlpha(100),
                      borderRadius: BorderRadius.circular(10)),
                  constraints: BoxConstraints(
                    maxWidth: width * (8 / 7),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Login_Type'.tr(),
                        style: AppTextStyles.textStyle2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const _MediumAuthType(),
                    ],
                  )),
              const _LoginButton(),
            ],
          ),
        ),
      );
    });
  }

  Widget _smallLayout(AuthCubit authCubit) {
    return Column(
      children: [
        getEmailField(authCubit),
        getPasswordField(authCubit),
        getHotelCode(authCubit),
        const _SmallSizeAuthType(),
        const SizedBox(height: 10),
        const _LoginButton(),
      ],
    );
  }

  Widget _passwordWidget(AuthCubit authCubit) {
    return GestureDetector(
      onTap: () => authCubit.changeVisiblePassword(),
      child: Icon(
        authCubit.getPasswordIcon(),
      ),
    );
  }
}

class _MediumAuthType extends StatelessWidget {
  const _MediumAuthType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final selectedAuthType =
            AuthCubit.instance(context).selectedAccountType;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AuthTypeWidget('assets/images/icons/supervisor.svg',
                type: LoginAuthType.supervisor,
                isSelected: selectedAuthType == LoginAuthType.supervisor,
                displayTypeString: 'Supervisor'.tr()),
            AuthTypeWidget('assets/images/icons/employee.svg',
                type: LoginAuthType.employee,
                isSelected: selectedAuthType == LoginAuthType.employee,
                displayTypeString: 'Employee'.tr()),
          ],
        );
      },
    );
  }
}

class _SmallSizeAuthType extends StatelessWidget {
  const _SmallSizeAuthType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final selectedAuthType =
            AuthCubit.instance(context).selectedAccountType;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: AuthTypeWidget('assets/images/icons/supervisor.svg',
                  type: LoginAuthType.supervisor,
                  isSelected: selectedAuthType == LoginAuthType.supervisor,
                  displayTypeString: 'Supervisor'.tr()),
            ),
            Expanded(
              child: AuthTypeWidget('assets/images/icons/employee.svg',
                  type: LoginAuthType.employee,
                  isSelected: selectedAuthType == LoginAuthType.employee,
                  displayTypeString: 'Employee'.tr()),
            ),
          ],
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;
        final loading = state is LoadingLoginState;
        final authCubit = AuthCubit.instance(context);
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width * (2 / 3)),
            child: DefaultButton(
                text: 'Login'.tr(),
                loading: loading,
                onPressed: () async {
                  if (authCubit.formKey.currentState!.validate()) {
                    await AuthCubit.instance(context).login(context);
                  }
                }),
          ),
        );
      },
    );
  }
}
