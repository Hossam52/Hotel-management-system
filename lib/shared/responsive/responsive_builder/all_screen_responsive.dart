import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:htask/shared/responsive/responsive.dart';
import 'package:htask/shared/responsive/responsive_utils/responsive_methods.dart';

class AllScreenResponsive extends StatelessWidget {
  const AllScreenResponsive({
    Key? key,
    required this.child,
    // this.mediumChild,
    // this.largeChild,
    // this.xLargeChild,
  }) : super(key: key);

  final Widget child;
  // final Widget? mediumChild;
  // final Widget? largeChild;
  // final Widget? xLargeChild;
  // //
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final maxWidth = deviceSize.width;
    final layoutConfigs = LayoutSizeConfig(
      maxDeviceWidth: maxWidth,
      smallChild: child,
      // mediumChild: mediumChild,
      // largeChild: largeChild,
      // xLargeChild: xLargeChild,
    );
    log(layoutConfigs.sizeConfig.breakPoint.toString());
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaleFactor: getTextScaleFactor(maxWidth)),
      child: layoutConfigs.sizeConfig.child,
    );
  }
}
