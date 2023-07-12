import 'dart:ffi';

import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:calorie_tracker/src/prefs_keys/PlanConstants.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/MifflinStJeorCalculator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Graphing extends StatefulWidget {
  Graphing({super.key});

  @override
  State<Graphing> createState() => _GraphingState();
}

class _GraphingState extends State<Graphing> {
  List<String> _rangeOptions = ["Past 7 Days", "Past 30 Days", "Max"];
  List<String> _planOptions = ["Mifflin-St Jeor", "Custom"];
  String _selectedRange = "Past 7 Days";
  String _selectedPlan = "Mifflin-St Jeor";

  List<(double, DateTime)> foodItemDailyTotals(List<FoodItemEntry> entries) {
    // sort the list into lists of entries and then fold them
    Map<DateTime, double> dailyEntriesMap = {};
    for (FoodItemEntry entry in entries) {
      if (!dailyEntriesMap.containsKey(entry.date.dateOnly)) {
        dailyEntriesMap[entry.date.dateOnly] = 0.0;
      }
      dailyEntriesMap[entry.date.dateOnly] =
          dailyEntriesMap[entry.date.dateOnly]! + evaluateFoodItem(entry.calorieExpression);
    }
    final sortedKeys = dailyEntriesMap.keys.toList()..sort((a, b) => a.dateOnly.difference(b.dateOnly).inDays);
    final List<(double, DateTime)> res = [];
    for (DateTime key in sortedKeys) {
      res.add((dailyEntriesMap[key]!, key));
    }
    return res;
  }

  int getPlanTarget(SharedPreferences? preferences) {
    if (preferences == null) {
      return -1;
    }
    if (_selectedPlan == _planOptions[0]) {
      double height = preferences.getDouble(USER_HEIGHT_DOUBLE) ?? 0.0;
      int heightFt = preferences.getInt(USER_HEIGHT_FT_INT) ?? 0;
      String gender = preferences.getString(USER_GENDER_STRING) ?? "";
      double weight = preferences.getDouble(USER_WEIGHT_DOUBLE) ?? 0.0;
      bool isMetric = preferences.getBool(MSJ_USE_METRIC_BOOL) ?? false;
      int age = preferences.getInt(USER_AGE_INT) ?? 0;
      String activityLevel = preferences.getString(USER_ACTIVITY_LEVEL_STRING) ?? "";

      final totalHeight = height + heightFt.toDouble() * 12.0;
      double bmr;
      if (gender == 'Male') {
        if (isMetric) {
          bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
        } else {
          bmr = (4.536 * weight) + (15.88 * totalHeight) - (5 * age) + 5;
        }
      } else {
        if (isMetric) {
          bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
        } else {
          bmr = (4.536 * weight) + (15.88 * totalHeight) - (5 * age) - 161;
        }
      }
      return (bmr * (MifflinStJeorCalculatorState.activityLevelOptions[activityLevel] ?? 0.0)).round();
    }
    if (_selectedPlan == _planOptions[1]) {
      return preferences.getDouble(USER_CUSTOM_TARGET_DOUBLE)?.round() ?? 0;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedRange = _rangeOptions[0];
      _selectedPlan = _planOptions[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            Expanded(
                child: Center(
                    child: DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Date Range"),
              value: _selectedRange,
              onChanged: (newValue) {
                setState(() {
                  _selectedRange = newValue!;
                });
              },
              items: _rangeOptions.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ))),
            SizedBox(width: 10),
            Expanded(
                child: Center(
              child: Center(
                  child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: "Calories Goal Plan"),
                value: _selectedPlan,
                onChanged: (newValue) {
                  setState(() {
                    _selectedPlan = newValue!;
                  });
                },
                items: _planOptions.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            )),
            SizedBox(width: 10),
          ],
        ),
        FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, prefs) {
              if (prefs.hasData) {
                final DateTime endDate = DateTime.now().dateOnly;
                DateTime startDate = switch (_selectedRange) {
                  "Past 7 Days" => endDate.daysAgo(6),
                  "Past 30 Days" => endDate.daysAgo(29),
                  "Max" => endDate.daysAgo(100000000),
                  _ => endDate.daysAgo(6)
                };
                return FutureBuilder<List<FoodItemEntry>>(
                  future: DatabaseHelper.instance.getFoodItemsInRange(startDate, endDate),
                  builder: (context, foodItemEntries) {
                    if (foodItemEntries.hasData) {
                      final dailyTotals = foodItemDailyTotals(foodItemEntries.data!);
                      if (_selectedRange == "Max") {
                        startDate = endDate.daysAgo(endDate.difference(dailyTotals[0].$2.dateOnly).inDays);
                      }
                      final planTarget = getPlanTarget(prefs.data);
                      return Expanded(
                          child: LineChart(
                        LineChartData(
                            minX: 1,
                            maxX: endDate.difference(startDate).inDays.toDouble() + 2,
                            minY: 0,
                            maxY: dailyTotals
                                    .map((e) => e.$1)
                                    .fold(double.negativeInfinity, (prev, cur) => cur > prev ? cur : prev) *
                                2,
                            gridData: FlGridData(
                              show: true,
                              getDrawingHorizontalLine: (value) => FlLine(color: Colors.blueGrey, strokeWidth: 1),
                              getDrawingVerticalLine: (value) => FlLine(color: Colors.blueGrey, strokeWidth: 1),
                            ),
                            lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: Colors.orange.shade50,
                                    tooltipBorder: BorderSide(color: Colors.black),
                                    getTooltipItems: (touchedSpots) => touchedSpots
                                        .map((e) => LineTooltipItem(
                                            (e.barIndex == 0 ? "Day's Calories: " : "Maintenance Calories: ") +
                                                e.y.round().toString(),
                                            TextStyle(
                                              color: e.bar.color,
                                            )))
                                        .toList())),
                            lineBarsData: [
                              LineChartBarData(
                                spots: dailyTotals
                                    .map((e) => FlSpot(
                                        e.$2.dateOnly.difference(startDate.dateOnly).inDays.toDouble() + 1, e.$1))
                                    .toList(),
                                color: Colors.deepOrange,
                              ),
                              // needs to be updated for plans variations which aren't constant
                              LineChartBarData(
                                  spots: dailyTotals
                                      .map((e) => FlSpot(
                                          e.$2.dateOnly.difference(startDate.dateOnly).inDays.toDouble() + 1,
                                          planTarget.toDouble()))
                                      .toList(),
                                  color: Colors.red.shade800)
                            ]),
                      ));
                    }
                    return Text("Loading Entry Data...");
                  },
                );
              }
              return Text("Loading User Data...");
            }),
      ],
    ));
  }
}
