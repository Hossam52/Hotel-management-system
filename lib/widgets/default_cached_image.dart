import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultCachedImage extends StatelessWidget {
  const DefaultCachedImage({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imagePath, fit: BoxFit.fill);
  }
}
