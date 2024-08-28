import 'dart:async';

import 'package:flutter_demos/storage/db_storage/merit_record_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbStorage {
  DbStorage._();

  static DbStorage? _instance;

  static DbStorage get instance => _instance ??= DbStorage._();

  late Database _db;

  late MeritRecordDao _meritRecordDao;
  MeritRecordDao get meritRecordDao => _meritRecordDao;

  Future<void> open() async {
    String databasePath = await getDatabasesPath();
    String dbPath = path.join(databasePath, 'flutter_demo.db');
    _db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    _meritRecordDao = MeritRecordDao(_db);
  }


  void _onCreate(Database db, int version) async{
    await MeritRecordDao.createTable(db);
  }
}