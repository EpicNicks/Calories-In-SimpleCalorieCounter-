import 'dart:math';

import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:calorie_tracker/src/extensions/list_extensions.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:calorie_tracker/src/constants/prefs_keys/PlanConstants.dart';
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
  List<String> _planOptions = ["None", "Mifflin-St Jeor", "Custom"];
  String _selectedRange = "Past 7 Days";
  String _selectedPlan = "None";

  bool _showAverage = false;
  bool _excludeToday = false;

  String getLineTooltipTitle(int index) {
    if (index == 0) {
      return "Day's Calories";
    }
    if (_selectedPlan.toUpperCase() != "NONE") {
      if (index == 1) return "Maintenance Calories";
    }
    // only Average remains
    return "Range Average";
  }

  List<({double totalCalories, DateTime dateTime})> foodItemDailyTotals(List<FoodItemEntry> entries) {
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
    final List<({double totalCalories, DateTime dateTime})> res = [];
    for (DateTime key in sortedKeys) {
      res.add((totalCalories: dailyEntriesMap[key]!, dateTime: key));
    }
    return res;
  }

  int getPlanTarget(SharedPreferences? preferences) {
    if (preferences == null) {
      return -1;
    }
    if (_selectedPlan == _planOptions[1]) {
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
    if (_selectedPlan == _planOptions[2]) {
      return preferences.getInt(USER_CUSTOM_TARGET_INT) ?? 0;
    }
    return 0;
  }

  double calculateHorizontalInterval(DateTime startDate, DateTime endDate) {
    final int dateDifference = endDate.difference(startDate).inDays;
    return switch (dateDifference) {
      <= 10 => 1,
      <= 50 => 5,
      <= 100 => 10,
      _ => 1,
    };
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
                final DateTime endDate = _excludeToday ? DateTime.now().dateOnly.daysAgo(1) : DateTime.now();
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
                      final List<({double totalCalories, DateTime dateTime})> dailyTotals =
                          foodItemDailyTotals(foodItemEntries.data!);
                      final double average = dailyTotals.length > 0
                          ? dailyTotals.map((t) => t.totalCalories).fold(0.0, (prev, cur) => prev + cur) /
                              dailyTotals.length
                          : 0;
                      if (_selectedRange == "Max") {
                        startDate = endDate.daysAgo(endDate.difference(dailyTotals[0].dateTime.dateOnly).inDays);
                      }
                      final planTarget = getPlanTarget(prefs.data);
                      return Expanded(
                          child: LineChart(
                        LineChartData(
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  interval: calculateHorizontalInterval(startDate, endDate),
                                  showTitles: true,
                                  getTitlesWidget: (double d, TitleMeta tm) {
                                    return Text(d.round().toString());
                                  },
                                )),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 50,
                                        showTitles: true,
                                        getTitlesWidget: (double d, TitleMeta tm) {
                                          return Text(d.round().toString());
                                        })),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  interval: calculateHorizontalInterval(startDate, endDate),
                                  showTitles: true,
                                  getTitlesWidget: (double d, TitleMeta tm) {
                                    return Text("");
                                  },
                                )),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 50,
                                        showTitles: true,
                                        getTitlesWidget: (double d, TitleMeta tm) {
                                          return Text("");
                                        }))),
                            minX: 1,
                            maxX: endDate.difference(startDate).inDays.toDouble() + 1,
                            minY: max(
                                (dailyTotals.map((e) => e.totalCalories).toList()..add(planTarget.toDouble())).min -
                                    200,
                                0),
                            maxY: max(
                                (dailyTotals.map((e) => e.totalCalories).toList()..add(planTarget.toDouble())).max +
                                    200,
                                2000),
                            gridData: FlGridData(
                              show: true,
                              getDrawingHorizontalLine: (value) => FlLine(color: Colors.blueGrey, strokeWidth: 1),
                              getDrawingVerticalLine: (value) => FlLine(color: Colors.blueGrey, strokeWidth: 1),
                            ),
                            lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  fitInsideHorizontally: true,
                                    fitInsideVertically: true,
                                    tooltipBgColor: Colors.orange.shade50,
                                    tooltipBorder: BorderSide(color: Colors.black),
                                    getTooltipItems: (touchedSpots) => touchedSpots
                                        .map((e) => LineTooltipItem(
                                            "${getLineTooltipTitle(e.barIndex)} ${e.y.round()}",
                                            TextStyle(
                                              color: e.bar.color,
                                            )))
                                        .toList())),
                            lineBarsData: [
                              LineChartBarData(
                                spots: dailyTotals
                                    .map((e) => FlSpot(
                                        e.dateTime.dateOnly.difference(startDate.dateOnly).inDays.toDouble() + 1,
                                        e.totalCalories))
                                    .toList(),
                                color: Colors.deepOrange,
                              ),
                              // needs to be updated for plans variations which aren't constant
                              LineChartBarData(
                                  show: _selectedPlan.toUpperCase() != "NONE",
                                  spots: dailyTotals
                                      .map((e) => FlSpot(
                                          e.dateTime.dateOnly.difference(startDate.dateOnly).inDays.toDouble() + 1,
                                          planTarget.toDouble()))
                                      .toList(),
                                  color: Colors.red.shade800),
                              LineChartBarData(
                                  show: _showAverage,
                                  spots: dailyTotals
                                      .map((e) => FlSpot(
                                          e.dateTime.dateOnly.difference(startDate.dateOnly).inDays.toDouble() + 1,
                                          average))
                                      .toList(),
                                  color: Colors.green)
                            ]),
                      ));
                    }
                    return Text("Loading Entry Data...");
                  },
                );
              }
              return Text("Loading User Data...");
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Text("Show Average"),
            Switch(
                activeColor: ORANGE_FRUIT,
                inactiveTrackColor: Colors.grey,
                value: _showAverage,
                onChanged: (bool value) {
                  setState(() {
                    _showAverage = value;
                  });
                }),
            Spacer(flex: 1),
            Text("Exclude Today"),
            Switch(
                activeColor: ORANGE_FRUIT,
                inactiveTrackColor: Colors.grey,
                value: _excludeToday,
                onChanged: (value) {
                  setState(() {
                    _excludeToday = value;
                  });
                }),
            Spacer(flex: 1)
          ],
        )
      ],
    ));
  }
}
