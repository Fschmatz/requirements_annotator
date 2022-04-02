import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ApplicationDao {
  static const _databaseName = 'Req.db';
  static const _databaseVersion = 1;

  static const table = 'applications';
  static const columnIdApplication = 'id_application';
  static const columnName = 'name';
  static const columnDescription = 'description';

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  ApplicationDao._privateConstructor();

  static final ApplicationDao instance = ApplicationDao._privateConstructor();

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

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id_app DESC');
  }

  Future<List<Map<String, dynamic>>> queryAllRowsByName() async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM $table ORDER BY $columnName COLLATE NOCASE');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdApplication];
    return await db.update(table, row, where: '$columnIdApplication = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdApplication = ?', whereArgs: [id]);
  }
}
