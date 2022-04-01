import 'dart:developer';

import 'package:flutter/material.dart';
import '../responsive_utils/responsive_methods.dart';

import '../responsive.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  const ResponsiveLayoutWidget(
      {Key? key,
      required this.smallChild,
      this.mediumChild,
      this.largeChild,
      this.xLargeChild,
      this.minWidgetWidth,
      this.maxWidgetWidth})
      : super(key: key);
  //For restrict layout if supplied
  final double? minWidgetWidth;
  final double? maxWidgetWidth;
  //
  final Widget smallChild;
  final Widget? mediumChild;
  final Widget? largeChild;
  final Widget? xLargeChild;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final infinite = constraints.hasInfiniteWidth;
        final maxWidth = infinite ? deviceSize.width : constraints.maxWidth;
        final layoutConfigs = LayoutSizeConfig(
          maxDeviceWidth: maxWidth,
          smallChild: smallChild,
          mediumChild: mediumChild,
          largeChild: largeChild,
          xLargeChild: xLargeChild,
        );
        log(maxWidth.toString());
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.minWidth,
            maxWidth: maxWidgetWidth ?? constraints.maxWidth,
          ),
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: getTextScaleFactor(maxWidth)),
            child: layoutConfigs.sizeConfig.child,
          ),
        );
      },
    );
  }
}
