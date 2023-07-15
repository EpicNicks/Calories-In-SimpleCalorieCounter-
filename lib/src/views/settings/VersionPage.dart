import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionPage extends StatelessWidget {
  final releasesUrl = "github.com/EpicNicks/SimpleCalorieCounter/releases/latest";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange.shade500,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Spacer(flex: 1), Text("Get Current Version"), Spacer(flex: 1), Spacer(flex: 5)],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.orange.shade300,
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  var versionString = "loading";
                  if (snapshot.hasData){
                    versionString = snapshot.data!.version;
                  }
                  return Center(child: Text("version number: $versionString"));
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  Text(
                    "The current version can be found at the GitHub releases section below:",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Flexible(
                      child: Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            final uri = Uri(scheme: "https", path: releasesUrl);
                            try {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            } catch(ex) {}
                          },
                          child: Text(
                            "Click Here!",
                            style: Theme.of(context).textTheme.headlineLarge,
                          )),
                      Flexible(
                          child: Image.asset("assets/github-mark.png", height: 100, width: 100, fit: BoxFit.cover)),
                    ],
                  ))
                ],
              ),
            )));
  }
}
