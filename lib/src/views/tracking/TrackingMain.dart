import 'package:calorie_tracker/src/views/tracking/plan_calculators/MifflinStJeorCalculator.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/PlanCalculators.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker/src/views/tracking/Calendar.dart';

class TrackingMain extends StatefulWidget {
  const TrackingMain({super.key});

  @override
  State<TrackingMain> createState() => _TrackingMainState();
}

class _TrackingMainState extends State<TrackingMain> {
  int _selectedIndex = 0;

  final List<String> appbarTitles = [
    "Calorie Entry History",
    "Graphs",
    "Your Plan"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitles[_selectedIndex]),
        backgroundColor: Colors.orange.shade300,
      ),
      body: [
        CalendarPage(),
        Center(child: Text("Not Implemented Yet")),
        PlanCalculators()
      ][_selectedIndex],
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange.shade300),
              child: Center(
                child: Text("Progress Tracking Options", style: Theme.of(context).textTheme.titleMedium),
              ),
          ),
          ListTile(
            title: const Text("Calendar"),
            selected: _selectedIndex == 0,
            trailing: Icon(Icons.calendar_month),
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Charts"),
            selected: _selectedIndex == 1,
            trailing: Icon(Icons.stacked_line_chart),
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Your Plan"),
            selected: _selectedIndex == 2,
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
