import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultCachedImage extends StatelessWidget {
  const DefaultCachedImage(
      {Key? key, required this.imagePath, this.color, this.radius = 40})
      : super(key: key);
  final String imagePath;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: radius!,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     image: DecorationImage(
    //       fit: BoxFit.fill,
    //       image: CachedNetworkImageProvider(imagePath),
    //     ),
    //   ),
    // );
    return CircleAvatar(
      backgroundColor: color,
      backgroundImage: CachedNetworkImageProvider(imagePath),
      // child: ClipOval(
      //   child: CachedNetworkImage(imageUrl: imagePath, fit: BoxFit.fill),
      // ),
      radius: radius,
    );
  }
}
