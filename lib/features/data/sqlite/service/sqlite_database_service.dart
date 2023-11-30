import 'package:sqflite/sqflite.dart';
import 'package:testproject/features/constant/constants.dart';
import 'package:testproject/features/data/sqlite/sqlite_db.dart';

class SqliteDataBaseServices {
  Database? _database;

 // Getter method to get the SQLite database, initializing it if needed
  Future<Database> get dataBase async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

 // Method to initialize the SQLite database
  Future<Database> _initialize() async {
    final path = await fullPath;
    var dataBase = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return dataBase;
  }

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return '$path$nameDb';
  }

// Method to create the database by invoking the createTable method from SqliteDb
  Future<void> create(Database database, int version) async =>
      await SqliteDb().createTable(database);
}
