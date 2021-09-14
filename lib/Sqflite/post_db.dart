import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voltagelab/Sqflite/Model/post_model.dart';

class SqlPostDB {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initdb();
    return _database;
  }

  Future<Database> initdb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Post.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute("""
       CREATE TABLE MYTable (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       postid INTEGER,
       categoryid INTEGER,
       posttitle TEXT,
       postdate TEXT,
       postlink TEXT,
       postcontent TEXT,
       postimage TEXT
      )

      """);
    });
  }

  Future<bool> insertdata(Savepost savepost) async {
    final db = await initdb();
    db.insert("MYTable", savepost.toMap());
    return true;
  }

  Future<List<Savepost>> getdata() async {
    final db = await initdb();
    final List<Map<String, Object?>> datas = await db.query("MYTable");
    return datas.map((e) => Savepost.fromMap(e)).toList();
  }

  // update(Savepost savepost) async {
  //   final db = await initdb();
  //   var result = await db.update("MYTable", saveCategory.toMap(),
  //       where: "id = ?", whereArgs: [saveCategory.id]);
  //   return result;
  // }

  // orderupdate(SaveCategory saveCategory) async {
  //   final db = await initdb();
  //   var result = await db.update("MYTable", saveCategory.toMap(),
  //       where: "id = ?", whereArgs: [saveCategory.orderno]);
  //   return result;
  // }




  Future delete(int id) async {
    final db = await initdb();
    db.delete("MYTable", where: "id = ?", whereArgs: [id]);
  }
}
