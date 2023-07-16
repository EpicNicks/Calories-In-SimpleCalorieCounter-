extension list_extensions<T extends num> on List<T>{
  double get min {
    return toList().fold(double.infinity, (prev, cur) => cur < prev ? cur.toDouble() : prev);
  }
  double get max {
    return toList().fold(double.negativeInfinity, (prev, cur) => cur > prev ? cur.toDouble() : prev);
  }
  double sum(){
    return toList().fold(0, (prev, cur) => prev + cur);
  }
}