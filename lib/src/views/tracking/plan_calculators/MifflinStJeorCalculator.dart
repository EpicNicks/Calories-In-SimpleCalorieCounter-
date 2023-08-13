import 'package:calorie_tracker/src/constants/prefs_keys/PlanConstants.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/AnimatedToggle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MifflinStJeorCalculator extends StatefulWidget {
  @override
  State<MifflinStJeorCalculator> createState() => MifflinStJeorCalculatorState();
}

class MifflinStJeorCalculatorState extends State<MifflinStJeorCalculator> {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  static const Map<String, double> activityLevelOptions = {
    'Bedridden': 1,
    'Sedentary': 1.2,
    'Light/1-3 Days Per Week': 1.375,
    'Moderate/3-5 Days Per Week': 1.55,
    'Hard Exercise/6-7 Days Per Week': 1.725,
    'Extremely Active/Sports and Physical Job': 1.9
  };

  double _weight = 0.0;
  TextEditingController _weightController = TextEditingController(),
      _heightController = TextEditingController(),
      _heightFtController = TextEditingController(),
      _ageController = TextEditingController();
  double _height = 0.0;
  int _heightFt = 0;
  int _age = 0;
  String _gender = 'Male';
  String _activityLevel = activityLevelOptions.keys.toList()[1];
  double _calculatedCalories = 0.0;
  bool _isMetric = true;

  void calculateCalories() {
    final totalHeight = _height + _heightFt.toDouble() * 12.0;
    double bmr;
    if (_gender == 'Male') {
      if (_isMetric) {
        bmr = (10 * _weight) + (6.25 * _height) - (5 * _age) + 5;
      } else {
        bmr = (4.536 * _weight) + (15.88 * totalHeight) - (5 * _age) + 5;
      }
    } else {
      if (_isMetric) {
        bmr = (10 * _weight) + (6.25 * _height) - (5 * _age) - 161;
      } else {
        bmr = (4.536 * _weight) + (15.88 * totalHeight) - (5 * _age) - 161;
      }
    }
    setState(() {
      _calculatedCalories = bmr * activityLevelOptions[_activityLevel]!;
    });
  }

  void handleSwapSystem(bool toMetric, SharedPreferences prefs) {
    _isMetric = toMetric;
    prefs.setBool(MSJ_USE_METRIC_BOOL, toMetric);
    if (toMetric) {
      _height = (_height + _heightFt * 12) * 2.54;
      _weight = _weight * 0.4535924;
    } else {
      _heightFt = (_height / 2.54 / 12).floor();
      _height = _height / 2.54 % 12;
      _weight = _weight * 2.204623;
      _heightFtController.text = _heightFt.toString();
      prefs.setInt(USER_HEIGHT_FT_INT, _heightFt);
    }
    prefs.setDouble(USER_HEIGHT_DOUBLE, _height);
    prefs.setDouble(USER_WEIGHT_DOUBLE, _weight);
    setState(() {});

    _heightController.text = _height.toStringAsFixed(2);
    _weightController.text = _weight.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _preferences.then((SharedPreferences prefs) {
      setState(() {
        _gender = prefs.getString(USER_GENDER_STRING) ?? _gender;
        _isMetric = prefs.getBool(MSJ_USE_METRIC_BOOL) ?? _isMetric;
        _weight = prefs.getDouble(USER_WEIGHT_DOUBLE) ?? _weight;
        _height = prefs.getDouble(USER_HEIGHT_DOUBLE) ?? _height;
        _heightFt = prefs.getInt(USER_HEIGHT_FT_INT) ?? _heightFt;
        _age = prefs.getInt(USER_AGE_INT) ?? _age;
        _activityLevel = prefs.getString(USER_ACTIVITY_LEVEL_STRING) ?? _activityLevel;

        _weightController.text = _weight.toStringAsFixed(3);
        _heightController.text = _height.toStringAsFixed(2);
        _heightFtController.text = _heightFt.toString();
        _ageController.text = _age.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // handles the fact that items are stored with keys that are language non-specific
    // language changes should only be reflected in the UI
    final genders = ["Male", "Female"];
    final measurementSystems = ["Metric", "Imperial"];
    final Map<String, String> translationMap = {
      AppLocalizations.of(context)!.genderMale: "Male",
      AppLocalizations.of(context)!.genderFemale: "Female",
      AppLocalizations.of(context)!.metricOption: "Metric",
      AppLocalizations.of(context)!.imperialOption: "Imperial",
      AppLocalizations.of(context)!.activityLevelBedridden: activityLevelOptions.keys.elementAt(0),
      AppLocalizations.of(context)!.activityLevelSedentary: activityLevelOptions.keys.elementAt(1),
      AppLocalizations.of(context)!.activityLevelLight: activityLevelOptions.keys.elementAt(2),
      AppLocalizations.of(context)!.activityLevelModerate: activityLevelOptions.keys.elementAt(3),
      AppLocalizations.of(context)!.activityLevelHard: activityLevelOptions.keys.elementAt(4),
      AppLocalizations.of(context)!.activityLevelExtreme: activityLevelOptions.keys.elementAt(5)
    };

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              value: _gender,
              onChanged: (newValue) {
                final value = translationMap[newValue!]!;
                setState(() {
                  _gender = newValue!;
                });
                _preferences.then((SharedPreferences prefs) => prefs.setString(USER_GENDER_STRING, value));
              },
              items: genders.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(translationMap.keys.elementAt(translationMap.values.toList().indexOf(value))),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<SharedPreferences>(
                    future: _preferences,
                    builder: (BuildContext ctx, AsyncSnapshot<SharedPreferences> snapshot) {
                      if (snapshot.hasData) {
                        return ToggleButtons(
                          children: measurementSystems.map((e) => Text(translationMap.keys.elementAt(translationMap.values.toList().indexOf(e)))).toList(),
                          isSelected: [_isMetric, !_isMetric],
                          onPressed: (value){
                            if (!(_isMetric && value == 0 || !_isMetric && value == 1)){
                              _preferences.then((SharedPreferences prefs) {
                                handleSwapSystem(value == 0, prefs);
                              });
                            }
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor: Colors.red[700],
                          selectedColor: Colors.white,
                          fillColor: Colors.red[200],
                          color: Colors.red[400],
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                            minWidth: 160.0,
                          ),
                        );

                        // return AnimatedToggle(
                        //   initialValue: snapshot.data?.getBool(MSJ_USE_METRIC_BOOL) ?? true == true
                        //       ? AppLocalizations.of(context)!.metricOption
                        //       : AppLocalizations.of(context)!.imperialOption,
                        //   values: measurementSystems.map((e) => translationMap.keys.elementAt(translationMap.values.toList().indexOf(e))).toList(),
                        //   onToggleCallback: (value) {
                        //     _preferences.then((SharedPreferences prefs) {
                        //       handleSwapSystem(value == 0, prefs);
                        //     });
                        //   },
                        //   buttonColor: Colors.orange.shade700,
                        //   backgroundColor: Colors.grey.shade200,
                        //   textColor: Colors.black,
                        // );
                      } else {
                        return Text(AppLocalizations.of(context)!.loadingText);
                      }
                    })
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: _isMetric ? AppLocalizations.of(context)!.weightKg : AppLocalizations.of(context)!.weightLbs,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0.0;
                  _preferences.then((SharedPreferences prefs) => prefs.setDouble(USER_WEIGHT_DOUBLE, _weight));
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _isMetric
                    ? [
                        Expanded(
                          child: TextField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.heightMetric,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _height = double.parse(value);
                                _preferences
                                    .then((SharedPreferences prefs) => prefs.setDouble(USER_HEIGHT_DOUBLE, _height));
                              });
                            },
                          ),
                        )
                      ]
                    : [
                        Expanded(
                            child: TextField(
                          controller: _heightFtController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.heightFeet,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _heightFt = int.tryParse(value) ?? 0;
                              _preferences
                                  .then((SharedPreferences prefs) => prefs.setInt(USER_HEIGHT_FT_INT, _heightFt));
                            });
                          },
                        )),
                        Expanded(
                            child: TextField(
                          controller: _heightController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.heightInches,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _height = double.tryParse(value) ?? 0;
                              _preferences
                                  .then((SharedPreferences prefs) => prefs.setDouble(USER_HEIGHT_DOUBLE, _height));
                            });
                          },
                        )),
                      ]),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.age),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value) ?? 0;
                  _preferences.then((SharedPreferences prefs) => prefs.setInt(USER_AGE_INT, _age));
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.activityLevelLabel),
              value: _activityLevel,
              onChanged: (newValue) {
                setState(() {
                  _activityLevel = newValue ?? "";
                  _preferences
                      .then((SharedPreferences prefs) => prefs.setString(USER_ACTIVITY_LEVEL_STRING, _activityLevel));
                });
              },
              items: activityLevelOptions.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(translationMap.keys.elementAt(translationMap.values.toList().indexOf(value))),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange.shade500)),
              onPressed: () {
                calculateCalories();
              },
              child: Text(
                AppLocalizations.of(context)!.calculateButtonLabel,
                style: TextStyle(color: Colors.black, fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              AppLocalizations.of(context)!.estimatedDailyNeedsLabel(_calculatedCalories.round()),
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
