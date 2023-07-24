extension DateTimeExtensions on DateTime {
  DateTime get dateOnly {
    return DateTime(year, month, day);
  }
  DateTime daysAgo(int days){
    return subtract(Duration(days: days));
  }
}