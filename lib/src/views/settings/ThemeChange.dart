import 'package:calorie_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/ColorConstants.dart';

class ThemeChange extends StatefulWidget {
  ThemeChange({super.key});

  @override
  State<ThemeChange> createState() => _ThemeChangeState();
}

class _ThemeChangeState extends State<ThemeChange> {
  ButtonStyle getButtonStyle() => ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width / 4, 70)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
      backgroundColor: MaterialStatePropertyAll(ORANGE_FRUIT),
      textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black)));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Change App Theme"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Theme.of(context).colorScheme.background, ORANGE_FRUIT],
            stops: const [0, 1],
          ),
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  MyApp.of(context).changeTheme(ThemeMode.light);
                                },
                                style: getButtonStyle(),
                                child: Text("Light")),
                            TextButton(
                                onPressed: () {
                                  MyApp.of(context).changeTheme(ThemeMode.dark);
                                },
                                style: getButtonStyle(),
                                child: Text("Dark")),
                            TextButton(
                                onPressed: () {
                                  MyApp.of(context).changeTheme(ThemeMode.system);
                                },
                                style: getButtonStyle(),
                                child: Text("System"))
                          ],
                        );
                      } else {
                        return Text("Loading...");
                      }
                    }))
          ],
        ),
      ),
    ));
  }
}
