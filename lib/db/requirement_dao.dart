import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RequirementDao {
  static const _databaseName = 'Req.db';
  static const _databaseVersion = 1;

  static const table = 'requirements';
  static const columnId = 'id_requirement';
  static const columnName = 'name';
  static const columnNote = 'note';
  static const columnState = 'state'; // 0 func 1 ñ func
  static const columnAppId = 'id_app';

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  RequirementDao._privateConstructor();

  static final RequirementDao instance = RequirementDao._privateConstructor();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllByIdApp(int appId) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table WHERE $columnAppId=$appId ORDER BY id_requirement');
  }

  Future<List<Map<String, dynamic>>> queryAllByIdAppState(int appId, int state) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table WHERE $columnAppId=$appId AND $columnState=$state ORDER BY id_requirement');
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id_requirement DESC');
  }

  Future<List<Map<String, dynamic>>> queryAllRowsByName() async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM $table ORDER BY $columnName COLLATE NOCASE');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAllFromApplicantion(int idApp) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnAppId = ?', whereArgs: [idApp]);
  }
}
