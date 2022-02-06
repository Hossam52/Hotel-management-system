import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = AppColors.buttonColor})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

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
          shape: MaterialStateProperty.all(const StadiumBorder()),
        ));
  }
}
