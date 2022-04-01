const double minScaleFactorRatio = 0.7;
const double maxScaleFactorRatio = 1.3;

double getTextScaleFactor(double currentWidth) {
  final scaleFactor = currentWidth * 0.0028;
  if (scaleFactor < minScaleFactorRatio) return minScaleFactorRatio;
  if (scaleFactor > maxScaleFactorRatio) {
    return maxScaleFactorRatio;
  } else {
    return scaleFactor;
  }
}
