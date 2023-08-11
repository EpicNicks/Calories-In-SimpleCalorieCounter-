import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/views/settings/ImportExport.dart';
import 'package:calorie_tracker/src/views/settings/TipsHowTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'dart:io';
import 'FAQ.dart';
import 'SupportPage.dart';
import 'ThemeChange.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Map<String, Widget> menuButtons = {
    "FAQ": Faq(),
    "Tips and How Tos": TipsHowTo(),
    "App Theme": ThemeChange(),
    "Support the Developer": SupportPage(),
    //"Version/Update": VersionPage(),
  };

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid){
      final methodChannel = MethodChannel("android_version");
      methodChannel.invokeMethod("version_int").then((value){
        final int version = value as int;
        if (version >= 30 && !menuButtons.keys.contains("Export/Import Data")){
          menuButtons.addAll({
            "Export/Import Data": ImportExport()
          });
          setState(() {});
        }
      });
    }


    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Spacer(flex: 5), Text("Settings"), Spacer(flex: 1), Icon(Icons.settings), Spacer(flex: 5)],
          ),
        ),
        bottomNavigationBar: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot){
            String version = "loading...";
            if (snapshot.hasData){
              version = snapshot.data!.version;
              print(version);
            }
            else {
              version = "error fetching version";
            }
            return BottomAppBar(padding: EdgeInsets.zero, height: 48, child: Center(child: Text("version number: $version")));
          },
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: menuButtons.keys
                  .map((k) => Row(children: [
                Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => menuButtons[k]!));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((materialState) {
                            if (materialState.contains(MaterialState.pressed)) {
                              return Theme.of(context).colorScheme.background;
                            }
                            return Theme.of(context).colorScheme.background;
                          }),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.orange)),
                          )),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(k, style: Theme.of(context).textTheme.titleLarge)),
                    ))
              ]))
                  .toList()
          )
        )
    );
  }
}
