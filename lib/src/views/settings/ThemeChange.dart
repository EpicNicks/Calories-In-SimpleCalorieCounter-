import 'package:calorie_tracker/generated/l10n/app_localizations.dart';
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
      minimumSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width / 4, 70)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
      backgroundColor: WidgetStatePropertyAll(ORANGE_FRUIT),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black)));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(AppLocalizations.of(context)!.appThemeTitle),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Theme.of(context).colorScheme.surface, ORANGE_FRUIT],
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
                                child: Text(AppLocalizations.of(context)!.lightLabel)),
                            TextButton(
                                onPressed: () {
                                  MyApp.of(context).changeTheme(ThemeMode.dark);
                                },
                                style: getButtonStyle(),
                                child: Text(AppLocalizations.of(context)!.darkLabel)),
                            TextButton(
                                onPressed: () {
                                  MyApp.of(context).changeTheme(ThemeMode.system);
                                },
                                style: getButtonStyle(),
                                child: Text(AppLocalizations.of(context)!.systemLabel))
                          ],
                        );
                      } else {
                        return Text(AppLocalizations.of(context)!.loadingText);
                      }
                    }))
          ],
        ),
      ),
    ));
  }
}
