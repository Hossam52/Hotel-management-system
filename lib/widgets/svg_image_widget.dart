import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageWidget extends StatelessWidget {
  const SvgImageWidget(
      {Key? key,
      required this.path,
      this.width = 20,
      this.height = 20,
      this.color})
      : super(key: key);
  final String path;
  final double width;
  final double height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: BoxFit.fill,
    );
  }
}
