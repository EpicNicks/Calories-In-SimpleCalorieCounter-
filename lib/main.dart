import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:calorie_tracker/src/views/DailyCalories.dart';
import 'package:calorie_tracker/src/views/settings/Settings.dart';
import 'package:calorie_tracker/src/views/tracking/TrackingMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/l10n.dart';

const String THEME_MODE_INT = "THEME_MODE_INT";

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final themeIndex = await SharedPreferences.getInstance().then((preferences) => preferences.getInt(THEME_MODE_INT)) ??
      ThemeMode.system.index;
  DatabaseHelper.instance.optimize();
  runApp(MyApp(themeMode: ThemeMode.values[themeIndex]));
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;

  MyApp({super.key, required this.themeMode});

  @override
  State<MyApp> createState() => _MyAppState(themeMode);

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode;

  _MyAppState(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void changeTheme(ThemeMode newThemeMode) {
    SharedPreferences.getInstance().then((preferences) {
      preferences.setInt(THEME_MODE_INT, _themeMode.index);
    });
    setState(() {
      _themeMode = newThemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          textTheme: ThemeData.light().textTheme,
          textButtonTheme: ThemeData.light().textButtonTheme,
          primarySwatch: Colors.orange,
          useMaterial3: true,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            background: Colors.white,
            onBackground: Colors.orange,
            error: Colors.white,
            onError: Colors.red,
            onPrimary: ORANGE_FRUIT,
            primary: Colors.black,
            secondary: ORANGE_FRUIT,
            onSecondary: ORANGE_FRUIT,
            tertiary: Colors.black,
            onTertiary: ORANGE_FRUIT,
            surface: ORANGE_FRUIT,
            onSurface: Colors.black,
            onSurfaceVariant: Colors.orange,
            primaryContainer: ORANGE_FRUIT,
            onPrimaryContainer: ORANGE_FRUIT,
            secondaryContainer: Colors.yellow[100],
            onSecondaryContainer: ORANGE_FRUIT,
          ),
          drawerTheme: DrawerThemeData(backgroundColor: Colors.white)),
      darkTheme: ThemeData(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          textTheme: ThemeData.dark().textTheme,
          textButtonTheme: ThemeData.dark().textButtonTheme,
          textSelectionTheme: ThemeData.dark().textSelectionTheme,
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            background: Colors.black,
            onBackground: Colors.orange,
            error: Colors.black,
            onError: Colors.red,
            onPrimary: ORANGE_FRUIT,
            primary: Colors.black,
            secondary: ORANGE_FRUIT,
            onSecondary: Colors.black,
            tertiary: Colors.black,
            onTertiary: ORANGE_FRUIT,
            surface: Colors.black54,
            onSurface: Colors.orange,
            onSurfaceVariant: Colors.orange,
            primaryContainer: Colors.black38,
            onPrimaryContainer: ORANGE_FRUIT,
            secondaryContainer: Colors.grey.shade900,
            onSecondaryContainer: ORANGE_FRUIT,
          ),
          useMaterial3: true),
      themeMode: _themeMode,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const BottomTabBar(),
    );
  }
}

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusNode current = FocusScope.of(context);
          if (!current.hasPrimaryFocus) {
            current.unfocus();
          }
        },
        child: DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            bottomNavigationBar: SafeArea(
              child: TabBar(
                indicatorColor: Colors.red[500],
                labelColor: Colors.redAccent,
                overlayColor: MaterialStatePropertyAll(Colors.redAccent.shade100),
                tabs: const <Widget>[
                  Tab(
                    icon: Icon(Icons.calendar_month),
                  ),
                  Tab(
                    icon: Icon(Icons.restaurant),
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            ),
            body: const SafeArea(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: TrackingMain(),
                  ),
                  Center(
                    child: DailyCaloriesPage(),
                  ),
                  Center(
                    child: Settings(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
