import 'dart:io';

import 'package:calorie_tracker/generated/l10n/app_localizations.dart';
import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/views/settings/ImportExport.dart';
import 'package:calorie_tracker/src/views/settings/TipsHowTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'FAQ.dart';
import 'SupportPage.dart';
import 'ThemeChange.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Map<String, Widget> menuButtons = {};

  @override
  Widget build(BuildContext context) {
    menuButtons.addAll({
      AppLocalizations.of(context)!.faqLabel: Faq(),
      AppLocalizations.of(context)!.tipsLabel: TipsHowTo(),
      AppLocalizations.of(context)!.themeLabel: ThemeChange(),
      AppLocalizations.of(context)!.supportLabel: SupportPage(),
      //"Version/Update": VersionPage(),
    });

    if (Platform.isAndroid) {
      final methodChannel = MethodChannel("android_version");
      methodChannel.invokeMethod("version_int").then((value) {
        final int version = value as int;
        final exportImportTitle = AppLocalizations.of(context)!.exportImportLabel;
        if (version >= 30 && !menuButtons.keys.contains(exportImportTitle)) {
          menuButtons.addAll({exportImportTitle: ImportExport()});
          setState(() {});
        }
      });
    }

    return Scaffold(
        bottomNavigationBar: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            String version = AppLocalizations.of(context)!.loadingText;
            if (snapshot.hasData) {
              version = snapshot.data!.version;
              print(version);
            } else {
              version = "error fetching version";
            }
            return BottomAppBar(
                padding: EdgeInsets.zero,
                height: 48,
                child: Center(child: Text(AppLocalizations.of(context)!.versionLabel(version))));
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
                    .toList())));
  }
}
