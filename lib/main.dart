import 'package:calorie_tracker/generated/l10n/app_localizations.dart';
import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:calorie_tracker/src/views/DailyCalories.dart';
import 'package:calorie_tracker/src/views/search/Search.dart';
import 'package:calorie_tracker/src/views/settings/Settings.dart';
import 'package:calorie_tracker/src/views/tracking/Calendar.dart';
import 'package:calorie_tracker/src/views/tracking/CustomEntryTable.dart';
import 'package:calorie_tracker/src/views/tracking/Graphing.dart';
import 'package:calorie_tracker/src/views/tracking/plan_calculators/PlanCalculators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/l10n.dart';

const String THEME_MODE_INT = "THEME_MODE_INT";

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent, // <- this line
    systemNavigationBarIconBrightness: Brightness.light, // match your background
  ));

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
          error: Colors.white,
          onError: Colors.red,
          onPrimary: ORANGE_FRUIT,
          primary: Colors.black,
          secondary: ORANGE_FRUIT,
          onSecondary: ORANGE_FRUIT,
          tertiary: Colors.black,
          onTertiary: ORANGE_FRUIT,
          surface: Colors.white,
          onSurface: Colors.black,
          onSurfaceVariant: Colors.orange,
          primaryContainer: ORANGE_FRUIT,
          onPrimaryContainer: ORANGE_FRUIT,
          secondaryContainer: Colors.yellow[100],
          onSecondaryContainer: ORANGE_FRUIT,
        ),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
        appBarTheme: AppBarTheme(backgroundColor: Colors.orange, foregroundColor: Colors.black),
      ),
      darkTheme: ThemeData(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          textTheme: ThemeData.dark().textTheme,
          textButtonTheme: ThemeData.dark().textButtonTheme,
          textSelectionTheme: ThemeData.dark().textSelectionTheme,
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
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
      home: BottomTabBar(),
    );
  }
}

class BottomTabBar extends StatefulWidget {
  BottomTabBar({super.key});

  static BottomTabBarState of(BuildContext context) => context.findAncestorStateOfType<BottomTabBarState>()!;

  @override
  State<StatefulWidget> createState() {
    return BottomTabBarState();
  }
}

class BottomTabBarState extends State<BottomTabBar> {
  int _selectedIndex = 0;
  int _dailyCaloriesTotal = 0;

  DateTime _dayCurrentlyEditing = DateTime.now();
  DateTime get dayCurrentlyEditing => _dayCurrentlyEditing;
  set dayCurrentlyEditing(DateTime dateTime) {
    DatabaseHelper.instance.getFoodItems(dateTime.dateOnly).then((value) {
      DatabaseHelper.instance.getAllUserSymbols().then((userSymbols) {
        setState(() {
          _dayCurrentlyEditing = dateTime;
          _dailyCaloriesTotal = value
              .fold(
                  0.0,
                  (previousValue, element) =>
                      previousValue + evaluateFoodItemWithCommentAndSymbols(element.calorieExpression, userSymbols))
              .toInt();
          _selectedIndex = 0;
        });
      });
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      if (index != 0) {
        _dayCurrentlyEditing = DateTime.now().dateOnly;
        DatabaseHelper.instance.getFoodItems(DateTime.now().dateOnly).then((value) {
          DatabaseHelper.instance.getAllUserSymbols().then((userSymbols) {
            setState(() {
              _dailyCaloriesTotal = value
                  .fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + evaluateFoodItemWithCommentAndSymbols(element.calorieExpression, userSymbols))
                  .toInt();
            });
          });
        });
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> appbarTitles = [
      AppLocalizations.of(context)!.dailyCalorieTotal(_dailyCaloriesTotal),
      AppLocalizations.of(context)!.calorieEntryHistoryTitle,
      AppLocalizations.of(context)!.chartsMenuItem,
      AppLocalizations.of(context)!.yourPlanMenuItem,
      AppLocalizations.of(context)!.searchMenuItem,
      AppLocalizations.of(context)!.symbolTableMenu,
      AppLocalizations.of(context)!.settingsTitle,
    ];

    Widget getAppBar() {
      if (_selectedIndex == 6) {
        return Row(
          children: [Text(AppLocalizations.of(context)!.settingsTitle), Icon(Icons.settings)],
        );
      }
      return Text(appbarTitles[_selectedIndex]);
    }

    Widget getCurrentScreen() {
      return [
        DailyCaloriesPage(
          setDailyCalories: (dailyCalories) {
            setState(() {
              _dailyCaloriesTotal = dailyCalories;
            });
          },
          dateCurrentlyEditing: dayCurrentlyEditing,
        ),
        CalendarPage(bottomTabBarState: this),
        Graphing(),
        PlanCalculators(),
        Search(),
        CustomEntryTable(),
        Settings()
      ][_selectedIndex];
    }

    return GestureDetector(
        onTap: () {
          FocusNode current = FocusScope.of(context);
          if (!current.hasPrimaryFocus) {
            current.unfocus();
          }
        },
        onHorizontalDragUpdate: (dragDetails) {
          int sensitivity = 8;
          print("dragging ${dragDetails.delta.dx}");
          if (dragDetails.delta.dx > sensitivity) {
            if (!scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.openDrawer();
            }
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: getAppBar(),
          ),
          body: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: getCurrentScreen(),
                maintainBottomViewPadding: false,
              )),
          drawer: Drawer(
              child: SafeArea(
                  child: ListView(
            padding: EdgeInsets.zero,
            children: [
              createListTile(AppLocalizations.of(context)!.dailyCalorieTotal(_dailyCaloriesTotal), Icons.restaurant, 0),
              ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(AppLocalizations.of(context)!.calorieTrackingSubmenuTitle),
                  children: [
                    createListTile(AppLocalizations.of(context)!.calendarMenuItem, Icons.calendar_month, 1),
                    createListTile(AppLocalizations.of(context)!.chartsMenuItem, Icons.stacked_line_chart, 2),
                    createListTile(AppLocalizations.of(context)!.yourPlanMenuItem, Icons.monitor_weight_outlined, 3),
                    createListTile(AppLocalizations.of(context)!.searchMenuItem, Icons.search_outlined, 4),
                    createListTile(AppLocalizations.of(context)!.symbolTableMenu, Icons.table_chart_outlined, 5)
                  ]),
              createListTile(AppLocalizations.of(context)!.settingsTitle, Icons.settings, 6)
            ],
          ))),
        ));
  }

  ListTile createListTile(String title, IconData icon, int index) {
    return ListTile(
      title: Text(title),
      selected: _selectedIndex == index,
      trailing: Icon(icon),
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }
}
