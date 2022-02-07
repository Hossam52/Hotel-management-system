import 'package:flutter/material.dart';

import 'package:htask/models/service_model.dart';
import 'package:htask/models/tab_bar_model.dart';
import 'package:htask/widgets/service_item.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';
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
                child: _persons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _persons() {
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
            itemBuilder: (_, index) => const _PersonItem(),
            itemCount: 14,
          ),
        ),
      ),
    );
  }
}

class _PersonItem extends StatelessWidget {
  const _PersonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: FittedBox(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/pseronal_image.png'),
          radius: 46,
        ),
      ),
      title: Text(
        'Hossam Hassan',
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text('Electricity'),
      isThreeLine: true,
      trailing: Text(
        'Available',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
