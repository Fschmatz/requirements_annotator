import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbCreator {

  static const _databaseName = "Req.db";
  static const _databaseVersion = 1;
  static Database? _database;
  Future<Database> get database async =>
      _database ??= await initDatabase();

  DbCreator._privateConstructor();
  static final DbCreator instance = DbCreator._privateConstructor();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {



    await db.execute('''    
           CREATE TABLE apps (
             id_app INTEGER PRIMARY KEY,
             name TEXT NOT NULL, 
             description TEXT                    
          )        
          ''');

    await db.execute('''    
           CREATE TABLE requirements (
             id_requirement INTEGER PRIMARY KEY,
             name TEXT NOT NULL, 
             note TEXT,
             state INTEGER NOT NULL,  
             id_app INTEGER NOT NULL    
          )          
          ''');


    //direct inserts for tests
    Batch batch = db.batch();

    batch.insert('apps', {
      'id_app': 1,
      'name': 'Requirements App',
      'description': 'Application for writing down software requirements.',
    });

    batch.insert('requirements', {
      'id_requirement': 1,
      'name': 'Save requirements',
      'note': '',
      'state': 1,
      'id_app': 1
    });

    batch.insert('requirements', {
      'id_requirement': 2,
      'name': 'Show requirements list',
      'note': '',
      'state': 1,
      'id_app': 1
    });

    batch.insert('requirements', {
      'id_requirement': 3,
      'name': 'Sqlite Database',
      'note': 'Android default database',
      'state': 0,
      'id_app': 1
    });

    batch.insert('requirements', {
      'id_requirement': 4,
      'name': 'App themes: light, dark and system',
      'note': '',
      'state': 0,
      'id_app': 1
    });

    batch.insert('requirements', {
      'id_requirement': 5,
      'name': 'Use Flutter Framework',
      'note': '',
      'state': 0,
      'id_app': 1
    });




    await batch.commit(noResult: true);

  }
}

