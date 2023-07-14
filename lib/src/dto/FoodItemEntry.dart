import 'package:math_expressions/math_expressions.dart';

class FoodItemEntry {
  final int? id;
  final String calorieExpression;
  final DateTime date;

  const FoodItemEntry({this.id, required this.calorieExpression, required this.date});

  factory FoodItemEntry.fromMap(Map<String, dynamic> json) => FoodItemEntry(
      id: json['id'],
      calorieExpression: json['calorieExpression'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'calorieExpression': calorieExpression,
      'date': DateTime(date.year, date.month, date.day).millisecondsSinceEpoch
    };
  }
}

bool isConstant(String calorieExpression) {
  return double.tryParse(calorieExpression) != null;
}

double evaluateFoodItem(String calorieExpression) {
  try {
    // split off optional comment string
    calorieExpression = calorieExpression.split(":")[0].trim();
    // enable alternate expression symbols here
    calorieExpression = calorieExpression
        .replaceAll("x", "*")
        .replaceAll("÷", "/")
        // allows for comma separated values while maintaining the semantics of a list total; fold(+, [1,2,3]) == fold([1+2+3 <6>])
        .replaceAll(",", "+");
    // trim trailing math symbols
    if (calorieExpression.length > 1 && ["*", "/", "+"].contains(calorieExpression[calorieExpression.length - 1])){
      calorieExpression = calorieExpression.substring(0, calorieExpression.length - 1);
      print(calorieExpression);
    }

    Expression expression = Parser().parse(calorieExpression);
    final result = double.parse(expression.evaluate(EvaluationType.REAL, ContextModel()).toString());
    // avoids division by zero
    return result.isFinite ? result : 0;
  } catch (e) {
    return 0;
  }
}
