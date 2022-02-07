import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/home_header.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            _buildItem('Available', trailing: const CustomSwitch()),
            _buildItem('Report problem', imagePath: 'assets/images/report.png'),
            _buildItem('Logout', imagePath: 'assets/images/logout.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String text, {String? imagePath, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
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

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool val = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      trackColor: MaterialStateProperty.all(AppColors.white),
      activeColor: AppColors.doneColor,
      onChanged: (bool value) {
        setState(() {
          val = value;
        });
      },
      value: val,
    );
  }
}
