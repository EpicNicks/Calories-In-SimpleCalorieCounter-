import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:calorie_tracker/src/views/DailyCalories.dart';
import 'package:calorie_tracker/src/views/settings/Settings.dart';
import 'package:calorie_tracker/src/views/tracking/TrackingMain.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_store_plus/media_store_plus.dart';

final mediaStorePlugin = MediaStore();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper.instance.optimize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.notoSansTextTheme(), primarySwatch: Colors.orange, useMaterial3: true),
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
