import 'dart:io';

import 'package:calorie_tracker/src/dto/CustomSymbolEntry.dart';
import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/extensions/datetime_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const DAY_MILLIS = 86400000;
  static const FOOD_ITEM_TABLE = 'food_item';
  static const USER_SYMBOLS_TABLE = 'user_symbols';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'simple_calorie_tracker.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $FOOD_ITEM_TABLE(
        id INTEGER PRIMARY KEY,
        calorieExpression TEXT,
        date INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $USER_SYMBOLS_TABLE(
        id INTEGER PRIMARY KEY,
        name TEXT UNIQUE NOT NULL,
        expression TEXT
      )
    ''');
  }

  Future<List<FoodItemEntry>> getFoodItems(DateTime dateTime) async {
    Database db = await instance.database;
    final foodEntries =
        await db.query(FOOD_ITEM_TABLE, orderBy: 'id ASC', where: 'date=${dateTime.dateOnly.millisecondsSinceEpoch}');
    return foodEntries.isNotEmpty ? foodEntries.map((c) => FoodItemEntry.fromMap(c)).toList() : [];
  }

  Future<List<FoodItemEntry>> getFoodItemsInRange(DateTime startInclusive, DateTime endInclusive) async {
    Database db = await instance.database;
    final foodEntries = await db.query(FOOD_ITEM_TABLE,
        orderBy: 'id ASC',
        where:
            'date>=${startInclusive.dateOnly.millisecondsSinceEpoch} AND date <= ${endInclusive.dateOnly.millisecondsSinceEpoch}');
    return foodEntries.isNotEmpty ? foodEntries.map((c) => FoodItemEntry.fromMap(c)).toList() : [];
  }

  Future<FoodItemEntry?> getFirstFoodEntry() async {
    Database db = await instance.database;
    final topEntry = await db.query(FOOD_ITEM_TABLE, orderBy: 'date ASC', limit: 1);
    if (topEntry.isNotEmpty) {
      final top = topEntry.map((c) => FoodItemEntry.fromMap(c));
      if (top.isNotEmpty) {
        return top.first;
      }
    }
    return null;
  }

  Future<FoodItemEntry?> getLastFoodEntry() async {
    Database db = await instance.database;
    final lastEntry = await db.query(FOOD_ITEM_TABLE, orderBy: 'date DESC', limit: 1);
    if (lastEntry.isNotEmpty) {
      final last = lastEntry.map((e) => FoodItemEntry.fromMap(e));
      if (last.isNotEmpty) {
        return last.first;
      }
    }
    return null;
  }

  Future<List<FoodItemEntry>> getAllFoodItems({FoodItemSearchOptions? options}) async {
    Database db = await instance.database;

    final String orderDirection =
        (options?.entryOrder != null && options?.entryOrder == EntryOrder.DESC ? "DESC" : "ASC");
    final String column = switch (options?.columnFilterOption) {
      ColumnFilterOption.CALORIES => "calorieExpression",
      ColumnFilterOption.DATE => "date",
      ColumnFilterOption.ID => "id",
      null => "id",
    };

    final foodEntries = await db.query(FOOD_ITEM_TABLE, orderBy: '${column} ${orderDirection}');
    return foodEntries.isNotEmpty ? foodEntries.map((c) => FoodItemEntry.fromMap(c)).toList() : [];
  }

  Future<List<List<dynamic>>> getAllFoodItemsAsCsvRows() async {
    final entries = await getAllFoodItems();
    List<List<dynamic>> res = [
      ['id', 'calorieExpression', 'date']
    ];
    for (final entry in entries) {
      res.add([entry.id, entry.calorieExpression, entry.date]);
    }
    return res;
  }

  Future<int> addFoodEntry(FoodItemEntry foodItemEntry) async {
    Database db = await instance.database;
    return await db.insert(FOOD_ITEM_TABLE, foodItemEntry.toMap());
  }

  Future<int> addUserSymbol(CustomSymbolEntry symbolEntry) async {
    Database db = await instance.database;
    return await db.insert(USER_SYMBOLS_TABLE, symbolEntry.toMap());
  }

  Future<void> batchAddFoodEntries(List<FoodItemEntry> foodItemEntries) async {
    Database db = await instance.database;
    final Batch batch = db.batch();
    for (final entry in foodItemEntries) {
      batch.insert(FOOD_ITEM_TABLE, entry.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<int> updateFoodEntry(FoodItemEntry foodItemEntry) async {
    Database db = await instance.database;
    return await db.update(
        FOOD_ITEM_TABLE,
        {
          'id': foodItemEntry.id,
          'calorieExpression': foodItemEntry.calorieExpression,
          'date': foodItemEntry.date.dateOnly.millisecondsSinceEpoch
        },
        where: 'id=${foodItemEntry.id}');
  }

  Future<int> updateUserSymbol(CustomSymbolEntry symbolEntry) async {
    Database db = await instance.database;
    return await db.update(
        USER_SYMBOLS_TABLE, {'id': symbolEntry.id, 'name': symbolEntry.name, 'expression': symbolEntry.expression},
        where: 'id=${symbolEntry.id}');
  }

  Future<int> deleteFoodEntry(int id) async {
    Database db = await instance.database;
    return await db.delete(FOOD_ITEM_TABLE, where: "id=$id");
  }

  Future<int> deleteUserSymbol(int id) async {
    Database db = await instance.database;
    return await db.delete(USER_SYMBOLS_TABLE, where: "id=$id");
  }

  Future<List<CustomSymbolEntry>> getAllUserSymbols() async {
    Database db = await instance.database;
    final symbolEntries = await db.query(USER_SYMBOLS_TABLE, orderBy: 'id ASC');
    return symbolEntries.isNotEmpty ? symbolEntries.map((c) => CustomSymbolEntry.fromMap(c)).toList() : [];
  }

  Future<CustomSymbolEntry?> getUserSymbolByName(String name) async {
    Database db = await instance.database;
    final symbolEntries = await db.query(USER_SYMBOLS_TABLE, where: 'name = ?', whereArgs: [name]);
    return symbolEntries.isNotEmpty ? CustomSymbolEntry.fromMap(symbolEntries.first) : null;
  }

  Future<(List<FoodItemEntry> foodItems, List<CustomSymbolEntry> userSymbols)> getAllFoodItemsAndSymbols(
      {DateTime? date, DateTime? endDate}) async {
    List<FoodItemEntry> foodItems = date == null
        ? await getAllFoodItems()
        : endDate == null
            ? await getFoodItems(date)
            : await getFoodItemsInRange(date, endDate);
    return (foodItems, await getAllUserSymbols());
  }

  Future<int> clearFoodEntriesTable() async {
    final Database db = await instance.database;
    return await db.delete(FOOD_ITEM_TABLE);
  }

  // delete all empty entries from previous days, will probably run in a service
  Future<int> purgePreviousEmpty() async {
    Database db = await instance.database;
    return await db.delete(FOOD_ITEM_TABLE,
        where: 'calorieExpression = "" AND date < ${DateTime.now().dateOnly.millisecondsSinceEpoch - DAY_MILLIS}');
  }

  // purges previous entries and runs VACUUM on the db
  Future<void> optimize() async {
    await purgePreviousEmpty();
    Database db = await instance.database;
    await db.execute("VACUUM");
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add the user_symbols table for users upgrading from version 1
      await db.execute('''
      CREATE TABLE $USER_SYMBOLS_TABLE(
        id INTEGER PRIMARY KEY,
        name TEXT UNIQUE NOT NULL,
        expression TEXT
      )
    ''');
    }
  }
}

enum ColumnFilterOption { ID, CALORIES, DATE }

enum EntryOrder { ASC, DESC }

class FoodItemSearchOptions {
  final EntryOrder? entryOrder;
  final ColumnFilterOption? columnFilterOption;

  FoodItemSearchOptions({this.entryOrder, this.columnFilterOption});
}
