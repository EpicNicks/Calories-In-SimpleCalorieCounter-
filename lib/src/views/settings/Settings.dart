import 'package:flutter/material.dart';

import 'FAQ.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Map<String, Widget> menuButtons = {"FAQ": Faq()};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Spacer(flex: 5), Text("Settings"), Spacer(flex: 1), Icon(Icons.settings), Spacer(flex: 5)],
          ),
        ),
        body: Column(
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
                                return Colors.orange.shade500;
                              }
                              return Colors.orange[50];
                            }),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.orange)),
                            )),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("FAQ", style: Theme.of(context).textTheme.titleLarge)),
                      ))
                    ]))
                .toList()));
  }
}
