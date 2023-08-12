import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/views/tracking/Graphing.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/PlanCalculators.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker/src/views/tracking/Calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrackingMain extends StatefulWidget {
  const TrackingMain({super.key});

  @override
  State<TrackingMain> createState() => _TrackingMainState();
}

class _TrackingMainState extends State<TrackingMain> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> appbarTitles = [
      AppLocalizations.of(context)!.calorieEntryHistoryTitle,
      AppLocalizations.of(context)!.chartsMenuItem,
      AppLocalizations.of(context)!.yourPlanMenuItem,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitles[_selectedIndex]),
      ),
      body: [CalendarPage(), Graphing(), PlanCalculators()][_selectedIndex],
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
            child: Center(
              child: Text(AppLocalizations.of(context)!.calorieTrackingSubmenuTitle, style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.calendarMenuItem),
            selected: _selectedIndex == 0,
            selectedColor: ORANGE_FRUIT,
            trailing: Icon(Icons.calendar_month),
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.chartsMenuItem),
            selected: _selectedIndex == 1,
            selectedColor: ORANGE_FRUIT,
            trailing: Icon(Icons.stacked_line_chart),
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.yourPlanMenuItem),
            selected: _selectedIndex == 2,
            selectedColor: ORANGE_FRUIT,
            trailing: Icon(Icons.monitor_weight_outlined),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            },
          )
        ],
      )),
    );
  }
}
