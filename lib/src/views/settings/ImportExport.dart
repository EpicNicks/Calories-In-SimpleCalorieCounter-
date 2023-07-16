import 'dart:io';

import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({super.key});

  @override
  State<ImportExport> createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  final _androidDownloadPath = "/storage/emulated/0/Download/";
  String _progressString = "";
  final _buttonStyle = ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(150, 70)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
      backgroundColor: MaterialStatePropertyAll(ORANGE_FRUIT),
      textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black)));

  Future<void> exportData() async {
    final status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    if (await Permission.manageExternalStorage.request().isGranted) {
      final downloadPath = Platform.isAndroid ? _androidDownloadPath : (await getDownloadsDirectory())?.path ?? "";
      if (Platform.isAndroid) {
        setState(() {
          _progressString = "Exporting to csv...";
        });
        final DatabaseHelper db = await DatabaseHelper.instance;
        final List<List<dynamic>> csvRows = await db.getAllItemsAsCsvRows();
        final String csvString = ListToCsvConverter().convert(csvRows);
        final String fileName = "CaloriesInBackup_${DateTime.now().toString().split(" ").join("_")}";
        final String filePath = downloadPath + fileName;
        final File file = File(filePath);
        try {
          await file.writeAsString(csvString);
        } catch (e) {
          setState(() {
            _progressString = "failed to write data in $downloadPath";
          });
        }
        setState(() {
          _progressString = "written data to $fileName in $downloadPath";
        });
      }
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
                      TextButton(style: _buttonStyle, onPressed: () => exportData(), child: Text("Export", style: TextStyle(color: Colors.black))),
                      TextButton(style: _buttonStyle, onPressed: () => importData(), child: Text("Import", style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                Center(child: Text(_progressString))
              ],
            )));
  }
}
