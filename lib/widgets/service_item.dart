import 'package:flutter/material.dart';
import 'package:htask/models/service_model.dart';
import 'package:htask/styles/colors.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({Key? key, required this.serviceModel}) : super(key: key);
  final ServiceModel serviceModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: serviceModel.isSelected
              ? AppColors.selectedColor
              : AppColors.selectedColor.withOpacity(0.6),
          // backgroundImage: AssetImage(serviceModel.imagePath),
          child: Image.asset(serviceModel.imagePath),
          radius: 20,
        ),
        const SizedBox(width: 10),
        Text(serviceModel.name),
      ],
    );
  }
}
