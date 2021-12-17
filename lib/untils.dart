double getCorectChartSize(num a, num b) {
  //get correct size for problem chart analytics,
  if (a == 0) return 0;

  num total = a + b;
  double size = ((a / total) * 100).toDouble();

  return size;
}
