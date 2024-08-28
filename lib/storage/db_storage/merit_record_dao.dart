import 'package:sqflite/sqflite.dart';

import '../../muyu/models/merit_record.dart';

class MeritRecordDao {
  final Database database;

  MeritRecordDao(this.database);

  static String tableName = 'merit_record';

  static String tableSql = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id VARCHAR(64) PRIMARY KEY ,
      value INTEGER,
      image TEXT,
      audio TEXT,
      timestamp INTEGER
    );
  ''';

  static Future<void> createTable(Database db) async {
    return db.execute(tableSql);
  }

  // 插入数据
  Future<void> insert(MeritRecord record) async {
    await database.insert(tableName, record.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MeritRecord>> query() async {
    List<Map<String, Object?>> data = database.query(tableName) as List<
        Map<String, Object?>>;
    return data.map((e) =>
        MeritRecord(
            e['id'].toString(), e['timestamp'] as int, e['value'] as int,
            e['image'].toString(), e['audio'].toString())).toList();
  }
}
