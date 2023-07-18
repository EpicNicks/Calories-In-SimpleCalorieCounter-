import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({super.key});

  @override
  State<ImportExport> createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  static const MethodChannel _channel = MethodChannel("csv_downloader");

  static Future<String?> downloadCsv(String csvContent) async {
    try {
      final String? filePath = await _channel.invokeMethod('downloadCsv', {'csvContent': csvContent});
      return filePath;
    } catch (e) {
      print('Error downloading CSV: $e');
      return null;
    }
  }

  String _progressString = "";
  final _buttonStyle = ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(150, 70)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
      backgroundColor: MaterialStatePropertyAll(ORANGE_FRUIT),
      textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black)));

  Future<void> exportData() async {
    setState(() {
      _progressString = "saving file...";
    });
    final DatabaseHelper db = await DatabaseHelper.instance;
    final List<List<dynamic>> csvRows = await db.getAllItemsAsCsvRows();
    final String csvString = ListToCsvConverter().convert(csvRows);
    String? filePath = await downloadCsv(csvString);
    if (filePath != null) {
      setState(() {
        _progressString = "saved file to $filePath";
      });
    }
    else {
      setState(() {
        _progressString = "export unsuccessful";
      });
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
                      TextButton(
                          style: _buttonStyle,
                          onPressed: () => importData(),
                          child: Text("Import", style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30), child: Text(_progressString))
              ],
            )));
  }
}
