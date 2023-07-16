import 'dart:io';

import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const DAY_MILLIS = 86400000;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'simple_calorie_tracker.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE food_item(
        id INTEGER PRIMARY KEY,
        calorieExpression TEXT,
        date INTEGER
      )
    ''');
  }

  Future<List<FoodItemEntry>> getFoodItems(DateTime dateTime) async {
    Database db = await instance.database;
    final foodEntries =
    await db.query('food_item', orderBy: 'id ASC', where: 'date=${dateTime.dateOnly.millisecondsSinceEpoch}');
    return foodEntries.isNotEmpty ? foodEntries.map((c) => FoodItemEntry.fromMap(c)).toList() : [];
  }

  Future<List<FoodItemEntry>> getFoodItemsInRange(DateTime startInclusive, DateTime endInclusive) async {
    Database db = await instance.database;
    final foodEntries = await db.query(
        'food_item',
        orderBy: 'id ASC',
        where: 'date>=${startInclusive.dateOnly.millisecondsSinceEpoch} AND date <= ${endInclusive.dateOnly.millisecondsSinceEpoch}');
    return foodEntries.isNotEmpty ? foodEntries.map((c) => FoodItemEntry.fromMap(c)).toList() : [];
  }

  Future<FoodItemEntry?> getFirstEntry() async {
    Database db = await instance.database;
    final topEntry = await db.query('food_item', orderBy: 'date ASC', limit: 1);
    if (topEntry.isNotEmpty) {
      final top = topEntry.map((c) => FoodItemEntry.fromMap(c));
      if (top.isNotEmpty) {
        return top.first;
      }
    }
    return null;
  }

  Future<FoodItemEntry?> getLastEntry() async {
    Database db = await instance.database;
    final lastEntry = await db.query('food_item', orderBy: 'date DESC', limit: 1);
    if (lastEntry.isNotEmpty) {
      final last = lastEntry.map((e) => FoodItemEntry.fromMap(e));
      if (last.isNotEmpty) {
        return last.first;
      }
    }
    return null;
  }

  Future<List<FoodItemEntry>> getAllFoodItems() async {
    Database db = await instance.database;
    final foodEntries = await db.query('food_item', orderBy: 'id ASC');
    return foodEntries.isNotEmpty ? foodEntries.map((c) => FoodItemEntry.fromMap(c)).toList() : [];
  }

  Future<List<List<dynamic>>> getAllItemsAsCsvRows() async {
    final entries = await getAllFoodItems();
    List<List<dynamic>> res = [['id', 'calorieExpression', 'date']];
    for (final entry in entries) {
      res.add([entry.id, entry.calorieExpression, entry.date]);
    }
    return res;
  }

  Future<int> add(FoodItemEntry foodItemEntry) async {
    Database db = await instance.database;
    return await db.insert('food_item', foodItemEntry.toMap());
  }

  Future<int> update(FoodItemEntry foodItemEntry) async {
    Database db = await instance.database;
    return await db.update(
        'food_item',
        {
          'id': foodItemEntry.id,
          'calorieExpression': foodItemEntry.calorieExpression,
          'date': foodItemEntry.date.dateOnly.millisecondsSinceEpoch
        },
        where: 'id=${foodItemEntry.id}');
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('food_item', where: "id=$id");
  }

  // delete all empty entries from previous days, will probably run in a service
  Future<int> purgePreviousEmpty() async {
    Database db = await instance.database;
    return await db.delete('food_item', where: 'calorieExpression = "" AND date < ${DateTime
        .now()
        .dateOnly
        .millisecondsSinceEpoch - DAY_MILLIS}');
  }

  // purges previous entries and runs VACUUM on the db
  Future<void> optimize() async {
    await purgePreviousEmpty();
    Database db = await instance.database;
    await db.execute("VACUUM");
  }
}
