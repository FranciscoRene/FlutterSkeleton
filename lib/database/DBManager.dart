import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class DBManager {
  static const String DB_NAME = 'database.db';
  static const int VERSION = 1;

  static final DBManager _dbManager  = new DBManager._internal();
  DBManager._internal();

  static DBManager get instance => _dbManager;

  //Member
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async{
    //print("_onCreate");
    readAndExecuteSQLScript(db, 'database.sql');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    //print('_onUpgrade, oldVersion:   $oldVersion  , newVersion: $newVersion');

    for (int i = oldVersion; i < newVersion; i++) {
      String migrationName = 'from_${i}_to_${ i + 1 }.sql';
      print('Looking for migration file: $migrationName');
      readAndExecuteSQLScript(db, migrationName);
    }

  }

  readAndExecuteSQLScript(Database db, String fileName) async {

    String rawStr = await rootBundle.loadString('assets/$fileName');

    if (rawStr.isEmpty)
      print('SQL script file name is empty');
    else {
      print('Script found. Executing...');

      var statement = new StringBuffer();

      Iterable<String> list = LineSplitter.split(rawStr);
      list.forEach((line) {
        if (line?.isEmpty ?? true) {
          //Do nothing
        } else {
          statement.write(line);
          if (line.endsWith(';')) {
            //print('> $statement');
            db.execute(statement.toString());
            statement.clear();
          }
        }
      });
    }

  }

}