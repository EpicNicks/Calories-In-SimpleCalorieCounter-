import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  final kofiUrl = "ko-fi.com/epicnicks";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Support the Developer"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                      child: Text("If this app has helped you achieve your goals, appreciate it over other apps available to you, or whatever the reason, consider supporting me by sending me a tip on the ko-fi link below",
                          style: Theme.of(context).textTheme.bodyLarge))),
              Padding(padding: EdgeInsets.only(top: 50), child: Row(
                children: [
                  //
                  IconButton(onPressed: () async {
                    final uri = Uri(scheme: "https", path: kofiUrl);
                    try {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } catch(ex) {}
                  }, icon: Image.asset("assets/kofi-banner.png", height: 100, width: 300, fit: BoxFit.fill))
                ],
              ))
            ],
          )
        ),
      ),
    );
  }
}
