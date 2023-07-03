import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../dto/FoodItemEntry.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _startDate, _selectedDay = DateTime.now().dateOnly, _focusedDay;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getFirstEntry().then((firstEntry) {
      setState(() {
        _startDate = firstEntry?.date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_startDate == null) {
      return const SafeArea(
        child: Center(
          child: Text("You have no entries in your history yet"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Calorie Entry History"),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Text("Your first entry was on date: ${DateFormat.yMMMd().format(_startDate!)}"),
            ),
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: _startDate!,
              lastDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.orange.shade500,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange[400],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            FutureBuilder<List<FoodItemEntry>>(
              future: DatabaseHelper.instance.getFoodItems(_selectedDay ?? _startDate!),
              builder: (BuildContext context, AsyncSnapshot<List<FoodItemEntry>> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: Column(children: [
                    Center(
                      // can occur on dates between the start and end date that had no entries
                      child: Text(
                          "No Calorie Entries for the selected date: ${DateFormat.yMMMd().format(_selectedDay ?? _startDate!)}"),
                    ),
                  ]));
                } else {
                  return Expanded(
                      child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [Colors.orange.shade50, Colors.orange.shade100],
                              stops: const [0, 1],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Total Calories: ${snapshot.data!.map((e) => evaluateFoodItem(e.calorieExpression)).fold(0.0, (prev, cur) => prev + cur).round()}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          // material wrapper required to prevent overflow in the ListTile component
                          // source of the solution: https://github.com/flutter/flutter/issues/86584#issuecomment-917454525
                          child: Material(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  tileColor: index % 2 == 1 ? Colors.yellow[100] : Colors.white,
                                  dense: true,
                                  title: Text(
                                    style: Theme.of(context).textTheme.titleSmall,
                                    (!isConstant(snapshot.data![index].calorieExpression)
                                            ? "[${evaluateFoodItem(snapshot.data![index].calorieExpression).round()}]:   "
                                            : "") +
                                        snapshot.data![index].calorieExpression,
                                  ),
                                );
                              },
                            ),
                          ))
                    ],
                  ));
                }
              },
            )
          ],
        ),
      );
    }
  }
}
