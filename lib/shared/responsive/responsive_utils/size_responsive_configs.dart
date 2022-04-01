part of './responsive_break_points.dart';

abstract class _SizeConfig {
  final Widget child;
  _SizeConfig(this.child);
  //
  double get breakPoint;
  double get textScaleFactor;
  bool _comaptibleWithBreakPoint(double maxDeviceWidth);
}

class SmallSize extends _SizeConfig {
  SmallSize(Widget child) : super(child);

  @override
  double get breakPoint => 360;

  @override
  double get textScaleFactor => 0.8;

  @override
  bool _comaptibleWithBreakPoint(double maxDeviceWidth) =>
      breakPoint > maxDeviceWidth;
}

class MediumSize extends _SizeConfig {
  MediumSize(Widget child) : super(child);

  @override
  double get breakPoint => 720;

  @override
  double get textScaleFactor => 1;
  @override
  bool _comaptibleWithBreakPoint(double maxDeviceWidth) =>
      breakPoint > maxDeviceWidth;
}

class LargeSize extends _SizeConfig {
  LargeSize(Widget child) : super(child);

  @override
  double get breakPoint => 1025;

  @override
  double get textScaleFactor => 1.3;
  @override
  bool _comaptibleWithBreakPoint(double maxDeviceWidth) =>
      breakPoint > maxDeviceWidth;
}

class XLargeSize extends _SizeConfig {
  XLargeSize(Widget child) : super(child);

  @override
  double get breakPoint => 1450;

  @override
  double get textScaleFactor => 1.5;
  @override
  bool _comaptibleWithBreakPoint(double maxDeviceWidth) =>
      // breakPoint > maxDeviceWidth;
      true; //return true as it last size no bigger we make in the app
}
