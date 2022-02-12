import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/models/supervisor/all_employees_to_assign.dart';
import 'package:htask/screens/staff/cubit/staff_cubit.dart';
import 'package:htask/screens/staff/cubit/staff_state.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/default_cached_image.dart';
import 'package:htask/widgets/error_widget.dart';

class AssignStaffEmployeeToOrder extends StatelessWidget {
  const AssignStaffEmployeeToOrder(
      {Key? key, required this.roomId, required this.seID})
      : super(key: key);
  final String roomId;
  final int seID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select employee'),
      ),
      body: SafeArea(
        child: BlocProvider<StaffCubit>(
          create: (context) =>
              StaffCubit()..getAllStaffToAssign(context, roomId, seID),
          lazy: false,
          child:
              BlocBuilder<StaffCubit, StaffStates>(builder: (context, state) {
            if (state is LoadingAllEmployeesToAssignStaffState) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _persons(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _persons() {
    return BlocBuilder<StaffCubit, StaffStates>(builder: (context, state) {
      final employees =
          StaffCubit.instance(context).allEmployeesToAssign.employees;
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                employee: employees[index],
              ),
              itemCount: employees.length,
            ),
          ),
        ),
      );
    });
  }
}

class _PersonItem extends StatelessWidget {
  const _PersonItem({Key? key, required this.employee}) : super(key: key);
  final AvailableEmployeeToAssign employee;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: FittedBox(
        child: DefaultCachedImage(
          imagePath: employee.image,
        ),
      ),
      title: Text(
        employee.name,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text('Orders number count: ${employee.orderNum}'),
      isThreeLine: true,
      trailing: TextButton(
        onPressed: () {
          Navigator.pop(context, employee.id);
        },
        child: Text(
          'Select ${employee.name} ',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
