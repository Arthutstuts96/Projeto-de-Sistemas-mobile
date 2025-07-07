String formatMonetary(double value) {
  return value.toStringAsFixed(2).replaceAll(".", ",");
}
