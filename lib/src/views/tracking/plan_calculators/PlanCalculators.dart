import 'package:calorie_tracker/generated/l10n/app_localizations.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/CustomPlan.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/MifflinStJeorCalculator.dart';
import 'package:flutter/material.dart';

class PlanCalculators extends StatefulWidget {
  @override
  State<PlanCalculators> createState() => _PlanCalculatorsState();
}

class _PlanCalculatorsState extends State<PlanCalculators> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> _appbarTitles = [
      AppLocalizations.of(context)!.caloriesGoalPlanMSJ,
      AppLocalizations.of(context)!.caloriesGoalPlanCustom
    ];

    return Scaffold(
        appBar: AppBar(
          title: DropdownButton(
            isExpanded: true,
            style: Theme.of(context).textTheme.titleLarge,
            value: _appbarTitles[_selectedIndex],
            items: _appbarTitles.map((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedIndex = _appbarTitles.contains(value) ? _appbarTitles.indexOf(value!) : 0;
              });
            },
          ),
        ),
        body: [
          MifflinStJeorCalculator(),
          CustomPlan(),
        ][_selectedIndex]);
  }
}
