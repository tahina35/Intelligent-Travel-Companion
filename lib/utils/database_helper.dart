import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:itc/utils/database_utility.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ptittour.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // create activity table
    await db.execute('''
      CREATE TABLE ${DatabaseUtility.activityTableName} (
        ${DatabaseUtility.activityIdColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseUtility.activityImageColumn} TEXT,
        ${DatabaseUtility.activityLabelColumn} TEXT,
        ${DatabaseUtility.activityDescriptionColumn} TEXT
      )
    ''');

    await db.execute('''
      INSERT INTO ${DatabaseUtility.activityTableName} (
        ${DatabaseUtility.activityImageColumn},
        ${DatabaseUtility.activityLabelColumn},
        ${DatabaseUtility.activityDescriptionColumn}
        )
      VALUES
        ('indoor.png', 'Indoor', 'Enjoy museums, cozy cafés, and unique shops'),
        ('outdoor.png', 'Outdoor', 'Discover parks, iconic streets, and outdoor sights'),
        ('both.png', 'Both', 'Get a mix of the best indoor and outdoor experiences')
    ''');

  }

  Future close() async {
    final db = await instance.db;
    db.close();
  }
}