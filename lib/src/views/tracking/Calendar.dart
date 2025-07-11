import 'dart:io';

import 'package:calorie_tracker/generated/l10n/app_localizations.dart';
import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/dto/CustomSymbolEntry.dart';
import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../main.dart';
import '../../dto/FoodItemEntry.dart';

class CalendarPage extends StatefulWidget {
  final BottomTabBarState bottomTabBarState;
  CalendarPage({Key? key, required this.bottomTabBarState}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _startDate, _selectedDay = DateTime.now().dateOnly, _focusedDay;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getFirstFoodEntry().then((firstEntry) {
      setState(() {
        _startDate = firstEntry?.date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_startDate == null) {
      return SafeArea(
        child: Center(
          child: Text(AppLocalizations.of(context)!.emptyHistoryMsg),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: Text(AppLocalizations.of(context)!.yourFirstEntryText(
                  DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(_startDate!))),
            ),
            TableCalendar(
              calendarFormat: CalendarFormat.month,
              locale: Platform.localeName,
              focusedDay: _focusedDay ?? DateTime.now(),
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
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: ORANGE_FRUIT,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange[200],
                  shape: BoxShape.circle,
                ),
              ),
              availableCalendarFormats: {CalendarFormat.month: "Month"},
            ),
            FutureBuilder<(List<FoodItemEntry> foodItems, List<CustomSymbolEntry> userSymbols)>(
              future: DatabaseHelper.instance.getAllFoodItemsAndSymbols(date: _selectedDay ?? _startDate!),
              builder: (BuildContext context,
                  AsyncSnapshot<(List<FoodItemEntry> foodItems, List<CustomSymbolEntry> userSymbols)> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: Column(children: [
                    Center(
                        // can occur on dates between the start and end date that had no entries
                        child: Text(AppLocalizations.of(context)!.loadingText)),
                  ]));
                } else {
                  final List<FoodItemEntry> filteredSnapshotData =
                      snapshot.data!.$1.where((element) => element.calorieExpression.isNotEmpty).toList();
                  final List<CustomSymbolEntry> userSymbols = snapshot.data?.$2 ?? [];
                  return Expanded(
                      child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.caloriesTotalLabel(filteredSnapshotData
                                    .map((e) => evaluateFoodItemWithCommentAndSymbols(e.calorieExpression, userSymbols))
                                    .fold(0.0, (prev, cur) => prev + cur)
                                    .round()),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_selectedDay != null) {
                                    widget.bottomTabBarState.dayCurrentlyEditing = _selectedDay!;
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!.editCaloriesCalendarButton),
                                style: new ButtonStyle(
                                    backgroundColor:
                                        WidgetStateColor.resolveWith((states) => Color.fromARGB(255, 200, 200, 100))),
                              ),
                            ],
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
                              itemCount: filteredSnapshotData.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  tileColor: index % 2 == 0
                                      ? Theme.of(context).colorScheme.secondaryContainer
                                      : Theme.of(context).colorScheme.primaryContainer,
                                  dense: true,
                                  title: Text(
                                    style: Theme.of(context).textTheme.titleSmall,
                                    (!isConstant(filteredSnapshotData[index].calorieExpression)
                                            ? "( = ${evaluateFoodItemWithCommentAndSymbols(filteredSnapshotData[index].calorieExpression, userSymbols).round()} )   "
                                            : "") +
                                        filteredSnapshotData[index].calorieExpression,
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
