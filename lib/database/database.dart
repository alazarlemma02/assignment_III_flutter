import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const cartTable = 'Cart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  static Database?
      _database; //I can use a static modifier instead of a late modifier
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return null;
  }

  createDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "ShoppingCart.db");
    var database = await openDatabase(path, version: 1, onCreate: _initDB);
    return database;
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  _initDB(Database database, int version) async {
    await database.execute(
        'CREATE TABLE $cartTable(id INTEGER PRIMARY KEY, name TEXT, price DOUBLE, image TEXT, status BOOLEAN)');
  }
}
