extension list_extensions<T extends num> on List<T>{
  /**
   * Returns the min of the list, or infinity if the list is empty
   */
  double get min {
    return fold(double.infinity, (prev, cur) => cur < prev ? cur.toDouble() : prev);
  }

  /**
   * Returns the max of the list, or negative infinity if the list is empty
   */
  double get max {
    return fold(double.negativeInfinity, (prev, cur) => cur > prev ? cur.toDouble() : prev);
  }
  double sum(){
    return fold(0, (prev, cur) => prev + cur);
  }
}