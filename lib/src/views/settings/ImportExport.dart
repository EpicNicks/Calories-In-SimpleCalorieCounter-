import 'dart:convert';

import 'package:calorie_tracker/src/constants/ColorConstants.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../dto/FoodItemEntry.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({super.key});

  @override
  State<ImportExport> createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  static const MethodChannel _channel = MethodChannel("csv_downloader");

  static Future<({String? message, bool success})> downloadCsv(String csvContent) async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status == PermissionStatus.denied) {
      status = await Permission.manageExternalStorage.request();
    }
    if (status == PermissionStatus.granted) {
      final permissionResult = await Permission.manageExternalStorage.request();
      if (permissionResult.isGranted) {
        try {
          final String? filePath = await _channel.invokeMethod('downloadCsv', {'csvContent': csvContent});
          return (message: filePath, success: true);
        } catch (e) {
          return (message: "An error occurred when writing the csv. Exception: $e", success: false);
        }
      }
    }
    return (message: "Permissions not granted, cannot write backup.", success: false);
  }

  static Future<({String message, bool success})> uploadCsv(BuildContext context) async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status == PermissionStatus.denied) {
      status = await Permission.manageExternalStorage.request();
    }
    if (status == PermissionStatus.granted) {
      final permissionResult = await Permission.manageExternalStorage.request();
      if (permissionResult.isGranted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            dialogTitle: "Select your backup file", type: FileType.custom, withData: true, allowedExtensions: ["csv"]);
        if (result != null) {
          try {
            PlatformFile file = result.files.first;
            if (file.bytes != null) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Really OVERWRITE all data?", style: TextStyle(color: Colors.red)),
                        content: Text(
                            "This will clear all previous content. Ensure you have made a backup of your current data with 'Export' before proceeding"),
                        actions: [
                          TextButton(
                            style: Theme.of(context).textButtonTheme.style,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel", style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          TextButton(
                            style: Theme.of(context).textButtonTheme.style,
                            child: Text("Continue", style: Theme.of(context).textTheme.bodyMedium),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Are you sure?", style: TextStyle(color: Colors.red)),
                                        content: Text(
                                          "Ensure you have backed up your data with 'Export'. You cannot recover your initial data after.",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        actions: [
                                          TextButton(
                                            style: Theme.of(context).textButtonTheme.style,
                                            child: Text("Cancel", style: Theme.of(context).textTheme.bodyMedium),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            style: Theme.of(context).textButtonTheme.style,
                                            child: Text("Confirm Overwrite", style: Theme.of(context).textTheme.bodyMedium),
                                            onPressed: () async {
                                              // overwrite data (validate data, purge db table, write data)
                                              String csvString = utf8.decode(file.bytes!);
                                              final List<List<dynamic>> csvData =
                                                  CsvToListConverter().convert(csvString);
                                              // confirm all rows are valid
                                              for (final row in csvData) {
                                                if (row.length != 3) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                            title:
                                                                Text("Data was malformed, not all rows were length 3"),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                    Navigator.of(context).pop();
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("Ok"))
                                                            ],
                                                          ));
                                                  return;
                                                }
                                              }
                                              // ids can be ignored because they are auto-incremented by the db anyway
                                              final List<FoodItemEntry> entries = csvData
                                                  .skip(1)
                                                  .map((row) => FoodItemEntry.fromMap({
                                                        "id": null, // auto-increment handles this already
                                                        "calorieExpression": row[1].toString(),
                                                        "date": DateTime.parse(row[2]).millisecondsSinceEpoch
                                                      }))
                                                  .toList();

                                              await DatabaseHelper.instance.clearFoodEntriesTable();
                                              await DatabaseHelper.instance.batchAdd(entries);

                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            },
                          )
                        ],
                      ));

              return (message: "file had data, TODO", success: true);
            } else {
              return (message: "file was empty", success: false);
            }
          } catch (e) {
            return (message: "no file selected", success: false);
          }
        } else {
          return (message: "a file was not selected by the user", success: false);
        }
      }
    }
    return (message: "Read permissions not granted. Could not import.", success: false);
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
    ({String? message, bool success}) result = await downloadCsv(csvString);
    if (result.success) {
      setState(() {
        _progressString = "Saved file to ${result.message}";
      });
    } else {
      setState(() {
        _progressString = "Export unsuccessful. ${result.message}";
      });
    }
  }

  void importData(BuildContext context) async {
    final result = await uploadCsv(context);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Import/Export Calorie Data"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Text(
                    "You can convert your entry data to a CSV, saved locally. Ensure that you back up data before overwriting."),
                SizedBox(height: 10),
                Text(
                    "For export, this app requires you allow it to write to external storage as it is a .csv file and will ask for permission to do so"),
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
                          onPressed: () => importData(context),
                          child: Text("Import", style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30), child: Text(_progressString))
              ],
            )));
  }
}
