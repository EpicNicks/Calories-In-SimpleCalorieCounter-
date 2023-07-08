import 'package:calorie_tracker/src/views/tracking/plan_calculators/AnimatedToggle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MifflinStJeorCalculator extends StatefulWidget {
  @override
  _MifflinStJeorCalculatorState createState() => _MifflinStJeorCalculatorState();
}

class _MifflinStJeorCalculatorState extends State<MifflinStJeorCalculator> {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  static const _activityLevelOptions = <String, double>{
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
  String _activityLevel = _activityLevelOptions.keys.toList()[1];
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
      _calculatedCalories = bmr * _activityLevelOptions[_activityLevel]!;
    });
  }

  void handleSwapSystem(bool toMetric, SharedPreferences prefs) {
    _isMetric = toMetric;
    prefs.setBool("msj_use_metric", toMetric);
    if (toMetric) {
      _height = (_height + _heightFt * 12) * 2.54;
      _weight = _weight * 0.4535924;
    } else {
      _heightFt = (_height / 2.54 / 12).floor();
      _height = _height / 2.54 % 12;
      _weight = _weight * 2.204623;
      _heightFtController.text = _heightFt.toString();
      prefs.setInt("user_height_ft", _heightFt);
    }
    prefs.setDouble("user_height", _height);
    prefs.setDouble("user_weight", _weight);
    setState((){});

    _heightController.text = _height.toStringAsFixed(2);
    _weightController.text = _weight.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _preferences.then((SharedPreferences prefs) {
      setState(() {
        _gender = prefs.getString("user_gender") ?? _gender;
        _isMetric = prefs.getBool("msj_use_metric") ?? _isMetric;
        _weight = prefs.getDouble("user_weight") ?? _weight;
        _height = prefs.getDouble("user_height") ?? _height;
        _heightFt = prefs.getInt("user_height_ft") ?? _heightFt;
        _age = prefs.getInt("user_age") ?? _age;
        _activityLevel = prefs.getString("user_activity_level") ?? _activityLevel;

        _weightController.text = _weight.toStringAsFixed(3);
        _heightController.text = _height.toStringAsFixed(2);
        _heightFtController.text = _heightFt.toString();
        _ageController.text = _age.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              value: _gender,
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue!;
                });
                _preferences.then((SharedPreferences prefs) => prefs.setString("user_gender", newValue!));
              },
              items: <String>['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
                        return AnimatedToggle(
                          initialValue: snapshot.data?.getBool("msj_use_metric") ?? true == true ? "Metric" : "Imperial",
                          values: ["Metric", "Imperial"],
                          onToggleCallback: (value) {
                            _preferences.then((SharedPreferences prefs) {
                              handleSwapSystem(value == 0, prefs);
                            });
                          },
                          buttonColor: Colors.orange.shade700,
                          backgroundColor: Colors.grey.shade200,
                          textColor: Colors.black,
                        );
                      } else {
                        return Text("loading...");
                      }
                    })
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: _isMetric ? 'Weight (kg)' : 'Weight (lbs)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0.0;
                  _preferences.then((SharedPreferences prefs) => prefs.setDouble("user_weight", _weight));
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
                              labelText: 'Height (cm)',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _height = double.parse(value);
                                _preferences.then((SharedPreferences prefs) => prefs.setDouble("user_height", _height));
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
                            labelText: 'Height (ft)',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _heightFt = int.tryParse(value) ?? 0;
                              _preferences.then((SharedPreferences prefs) => prefs.setInt("user_height_ft", _heightFt));
                            });
                          },
                        )),
                        Expanded(
                            child: TextField(
                          controller: _heightController,
                          decoration: InputDecoration(
                            labelText: 'Height (in)',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _height = double.tryParse(value) ?? 0;
                              _preferences.then((SharedPreferences prefs) => prefs.setDouble("user_height", _height));
                            });
                          },
                        )),
                      ]),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value) ?? 0;
                  _preferences.then((SharedPreferences prefs) => prefs.setInt("user_age", _age));
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Your activity level"),
              value: _activityLevel,
              onChanged: (newValue) {
                setState(() {
                  _activityLevel = newValue!;
                });
              },
              items: _activityLevelOptions.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
                'Calculate',
                style: TextStyle(color: Colors.black, fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Estimated Daily Calorie Needs: ${_calculatedCalories.round()}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
