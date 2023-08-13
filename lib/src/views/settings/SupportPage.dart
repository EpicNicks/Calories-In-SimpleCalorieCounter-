import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupportPage extends StatelessWidget {
  final kofiUrl = "ko-fi.com/epicnicks";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.supportTitle),
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
                      child: Text(AppLocalizations.of(context)!.supportBody,
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
