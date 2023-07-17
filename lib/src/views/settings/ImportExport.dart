import 'dart:io';

import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({super.key});

  @override
  State<ImportExport> createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  String _progressString = "";
  final _buttonStyle = ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(150, 70)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
      backgroundColor: MaterialStatePropertyAll(ORANGE_FRUIT),
      textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black)));

  String htmlString(String csvString) {
    return """
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>
      CSV Backup View
    </title>
  </head>
  <body>
    <!-- <h1>CSV Viewer</h1> -->
    <!-- <p>Click the link below to download your CSV</p> -->
    <!-- <a href="data:text/csv;charset=utf-8,${Uri.encodeComponent(csvString)}" download="backup_${DateTime.now().toString().split(" ").join("_")}.csv">Download CSV</a> -->
    <pre>$csvString</pre>
  </body>
</html>
""";
  }

  Future<void> exportData() async {
    final DatabaseHelper db = await DatabaseHelper.instance;
    final List<List<dynamic>> csvRows = await db.getAllItemsAsCsvRows();
    final String csvString = ListToCsvConverter().convert(csvRows);
    final File file = File((await getApplicationSupportDirectory()).path + "/" + "backup.csv");
    file.writeAsString(csvString);
    // await launchUrl(Uri(scheme: "file", path: file.path), mode: LaunchMode.externalApplication);

    try {
      WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (url) {},
          onPageFinished: (url) {},
        ));
      controller.loadHtmlString(htmlString(csvString));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SafeArea(child: WebViewWidget(controller: controller))));

      // setState(() {
      //   _progressString = "written data";
      //   print(_progressString);
      // });
    } catch (e) {
      // print(e);
      // setState(() {
      //   _progressString = "failed to write data";
      // });
    }
  }

  void importData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Import/Export Calorie Data"),
          backgroundColor: ORANGE_FRUIT,
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Center(
                    child: Text(
                        "You can convert your entry data to a CSV, saved locally. Ensure that you back up data before overwriting.")),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          style: _buttonStyle,
                          onPressed: () => exportData(),
                          child: Text("Export", style: TextStyle(color: Colors.black))),
                      // TextButton(
                      //     style: _buttonStyle,
                      //     onPressed: () => importData(),
                      //     child: Text("Import", style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30), child: Text(_progressString))
              ],
            )));
  }
}
