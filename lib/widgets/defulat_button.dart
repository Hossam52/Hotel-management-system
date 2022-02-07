import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = AppColors.buttonColor,
      this.radius = 18})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(text),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(18.0)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
          ),
        ));
  }
}
