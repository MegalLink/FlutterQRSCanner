import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final _scanTableName = 'Scans';
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
          CREATE TABLE $_scanTableName(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
      ''');
    })); // change version every time we change db structure
  }

  /// Inserts record in database a returns its index.
  Future<int> insertNewScan(ScanModel newScan) async {
    final db = await database;
    return await db.insert(_scanTableName, newScan.toMap());
  }

  Future<ScanModel> getScanByID(int id) async {
    final db = await database;
    final res =
        await db.query(_scanTableName, where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }

    return ScanModel(value: 'error');
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res =
        await db.query(_scanTableName, where: 'type = ?', whereArgs: [type]);

    if (res.isNotEmpty) {
      return res.map((scan) => ScanModel.fromMap(scan)).toList();
    }

    return List.empty();
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query(_scanTableName);
    print(res);
    if (res.isNotEmpty) {
      return res.map((scan) => ScanModel.fromMap(scan)).toList();
    }

    return List.empty();
  }

  /// Updates record in database and returns its index.
  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    return await db.update(_scanTableName, newScan.toMap(),
        where: 'id = ?', whereArgs: [newScan.id]);
  }

  /// Deletes record in database a returns its index.
  Future<int> deleteScan(int id) async {
    final db = await database;
    return await db.delete(_scanTableName, where: 'id = ?', whereArgs: [id]);
  }

  /// Deletes all records in database and returns the number of elements deleted
  Future<int> deleteAllScans() async {
    final db = await database;
    return await db.delete(_scanTableName);
  }
}
