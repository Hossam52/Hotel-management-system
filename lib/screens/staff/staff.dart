import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/supervisor/supervisor_employees/supervisor_employee_model.dart';
import 'package:htask/screens/staff/cubit/staff_cubit.dart';
import 'package:htask/screens/staff/cubit/staff_state.dart';
import 'package:htask/shared/constants/methods.dart';

import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
import 'package:htask/widgets/custom_switch.dart';
import 'package:htask/widgets/default_cached_image.dart';
import 'package:htask/widgets/default_circular_progress.dart';
import 'package:htask/widgets/error_widget.dart';
import 'package:htask/widgets/home_header.dart';
import 'package:htask/widgets/services_toaday.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
        backgroundColor: AppColors.lightPrimary,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(padding),
                child: SizedBox(
                    height: height * 0.13, child: const ServiceToday()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _persons(context),
              ),
            ],
          ),
        )));
  }

  Widget _persons(context) {
    return BlocConsumer<StaffCubit, StaffStates>(
      bloc: StaffCubit.instance(context)..getMyEmployees(context),
      listener: (_, state) {
        if (state is SuccessChangingEmployeeStatus) {
          showSuccessToast(state.message);
        }
        if (state is ErrorChangingEmployeeStatus) showErrorToast(state.error);
      },
      builder: (context, state) {
        final staffCubit = StaffCubit.instance(context);
        if (state is LoadingMyEmployeesStaffState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorMyEmployeesStaffState) {
          return DefaultErrorWidget(
              refreshMethod: () => staffCubit.getMyEmployees(context));
        }
        final employees = staffCubit.supervisorEmployees;
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: ListView.separated(
                    separatorBuilder: (_, index) => const Divider(
                      thickness: 1,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => _PersonItem(
                      employeeIndex: index,
                    ),
                    itemCount: employees.length,
                  ),
                )));
      },
    );
  }
}

class _PersonItem extends StatelessWidget {
  const _PersonItem({Key? key, required this.employeeIndex}) : super(key: key);
  final int employeeIndex;
  @override
  Widget build(BuildContext context) {
    final employee = StaffCubit.instance(context).getEmployee(employeeIndex);
    return ListTile(
        onTap: () => _onTap(context, employee),
        contentPadding: const EdgeInsets.all(0),
        leading:
            FittedBox(child: DefaultCachedImage(imagePath: employee.image)),
        title: Text(
          employee.name,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text('Email: ${employee.email}'),
        isThreeLine: true,
        trailing: _availableWidget(context, employee.isBlocked));
  }

  Widget _availableWidget(BuildContext context, bool isBlocked) {
    return Column(
      children: [
         Text(
          'Available'.tr(),
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: CustomSwitch(
            val: isBlocked,
            onToggle: (val) async {
              await StaffCubit.instance(context)
                  .changeEmployeeStatus(context, employeeIndex);
            },
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context, SupervisorEmployeeModel employee) async {
    await showDialog(
        context: context,
        builder: (_) => Dialog(
            insetPadding: const EdgeInsets.all(16),
            backgroundColor: AppColors.lightPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.hardEdge,
            child: _EmployeeResponsibilitiesWidget(employee: employee)));
  }
}

class _EmployeeResponsibilitiesWidget extends StatelessWidget {
  const _EmployeeResponsibilitiesWidget({Key? key, required this.employee})
      : super(key: key);
  final SupervisorEmployeeModel employee;
  @override
  Widget build(BuildContext context) {
    final res = employee.res;
    return Column(
      children: [
        _buildPerson(),
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              primary: true,
              itemBuilder: (_, index) {
                return _buildResponsibilityItem(res[index]);
              },
              separatorBuilder: (_, index) => const Divider(thickness: 1),
              itemCount: res.length),
        ),
      ],
    );
  }

  Widget _buildPerson() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      color: AppColors.blue1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            DefaultCachedImage(imagePath: employee.image),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Responsibilities for  ${employee.name}',
                  style: AppTextStyles.textStyle1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsibilityItem(EmployeeResponsibilitiesModel res) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(res.unit,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18)),
            ),
            Row(children: [
              Flexible(
                  child:
                      Center(child: _richText('${"FromRoom".tr()}: ', res.form_room))),
              Flexible(
                  child: Center(child: _richText('To room: ', res.to_room))),
            ]),
            _richText('${"Floor".tr()}: ', res.floor)
          ],
        ),
      ),
    );
  }

  Widget _richText(String key, String value) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: key,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 13),
          )
        ],
      ),
    );
  }
}
