import 'package:flutter/material.dart';

double getCorectChartSize(num a, num b) {
  //get correct size for problem chart analytics,
  if (a == 0) return 0;

  num total = a + b;
  double size = ((a / total) * 100).toDouble();

  return size;
}

bool isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

bool isLandscape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

bool _isTablet(BuildContext context) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide > 600;
}

bool _isSmallDevice(BuildContext context) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide < 330;
}

Size _getSizeByOrentation(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return isLandscape(context) ? Size(size.height, size.width) : size;
}

double getFontSizeByScreen(BuildContext context, double fontSize) {
  double tabletHeightValue = _getSizeByOrentation(context).height * 0.00115;
  double smallHeightValue = _getSizeByOrentation(context).height * 0.0014;

  if (_isTablet(context)) {
    return tabletHeightValue * fontSize;
  }
  if (_isSmallDevice(context)) {
    return smallHeightValue * fontSize;
  } else {
    return fontSize;
  }
}
