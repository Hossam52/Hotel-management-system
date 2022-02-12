import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:htask/models/categories/category_model.dart';
import 'package:htask/models/service_model.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/default_cached_image.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({Key? key, required this.category, required this.selected})
      : super(key: key);
  final CategoryModel category;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selected
              ? AppColors.selectedColor
              : AppColors.selectedColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          DefaultCachedImage(
              radius: 25,
              color: selected
                  ? AppColors.selectedColor
                  : AppColors.selectedColor.withOpacity(0.6),
              imagePath: category.image),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category.name),
          ),
        ],
      ),
    );
  }
}
