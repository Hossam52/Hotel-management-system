import 'package:flutter/material.dart';

part './size_responsive_configs.dart';

class LayoutSizeConfig {
  final Widget smallChild;
  final Widget? mediumChild;
  final Widget? largeChild;
  final Widget? xLargeChild;
  //
  late _SizeConfig sizeConfig;

  ///Recieve all widgets with different sizes and determine what to display
  ///small child is @required and other not
  ///if medium is null then small is returned
  ///if large is null then assign medium if not null and if null then assign small
  LayoutSizeConfig(
      {required double maxDeviceWidth,
      required this.smallChild,
      this.mediumChild,
      this.largeChild,
      this.xLargeChild}) {
    //Define for locating all sizes and then get its corresponding size
    final SmallSize smallSize = SmallSize(smallChild);
    final MediumSize mediumSize = MediumSize(mediumChild ?? smallChild);
    final LargeSize largeSize =
        LargeSize(largeChild ?? mediumChild ?? smallChild);
    final XLargeSize xLargeSize =
        XLargeSize(xLargeChild ?? largeChild ?? mediumChild ?? smallChild);

    //Computation to assign size config with its approtiate size
    if (smallSize._comaptibleWithBreakPoint(maxDeviceWidth)) {
      sizeConfig = smallSize;
    } else if (mediumSize._comaptibleWithBreakPoint(maxDeviceWidth)) {
      sizeConfig = mediumSize;
    } else if (largeSize._comaptibleWithBreakPoint(maxDeviceWidth)) {
      sizeConfig = largeSize;
    } else if (xLargeSize._comaptibleWithBreakPoint(maxDeviceWidth)) {
      sizeConfig = xLargeSize;
    } else {
      sizeConfig = smallSize;
    }
  }
}
