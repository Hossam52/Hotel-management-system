import 'package:flutter/material.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/svg_image_widget.dart';

class AuthTypeWidget extends StatelessWidget {
  const AuthTypeWidget(
    this.imagePath, {
    Key? key,
    required this.type,
    required this.isSelected,
    required this.displayTypeString,
  }) : super(key: key);
  final String imagePath;
  final LoginAuthType type;
  final bool isSelected;
  final String displayTypeString;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          AuthCubit.instance(context).changeSelectedAccountType(type);
        },
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.darkPrimaryColor
                : Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  displayTypeString,
                  style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppColors.darkPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: SvgImageWidget(
                    path: imagePath,
                    color:
                        isSelected ? Colors.white : AppColors.darkPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
