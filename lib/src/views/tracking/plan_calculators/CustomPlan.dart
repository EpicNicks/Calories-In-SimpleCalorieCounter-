import 'package:calorie_tracker/src/constants/prefs_keys/PlanConstants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPlan extends StatefulWidget {
  @override
  State<CustomPlan> createState() => _CustomPlanState();
}

class _CustomPlanState extends State<CustomPlan> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(AppLocalizations.of(context)!.customGoalPlanPrompt),
          ),
        ),
        body: FutureBuilder<SharedPreferences>(
          future: prefs.then((SharedPreferences prefs) => prefs),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final paddingWidth = MediaQuery.of(context).size.width * 0.1;
              return Container(
                  padding: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
                  child: Column(children: [
                    TextFormField(
                      initialValue: (snapshot.data?.getInt(USER_CUSTOM_TARGET_INT) ?? 0).toString(),
                      onChanged: (value){
                        snapshot.data?.setInt(USER_CUSTOM_TARGET_INT, int.tryParse(value) ?? 0);
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ]));
            } else {
              return Column(children: [Text(AppLocalizations.of(context)!.loadingText)]);
            }
          },
        ));
  }
}
