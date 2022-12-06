import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //Important use extension .db is used for sqlite document
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onCreate: ((db, version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
      ''');
    })); // change version every time we change db structure
  }

  Future<int> insertNewScan(ScanModel newScan) async {
    final db = await database;
    return await db.insert('Scans', newScan.toMap());
  }
}
